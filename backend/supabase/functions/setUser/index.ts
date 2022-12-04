import { serve } from 'https://deno.land/std@0.131.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': '*', // <-- check this for security
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Create a Supabase client with the Auth context of the logged in user.
    const supabaseClient = createClient(
      // Supabase API URL - env var exported by default.
      Deno.env.get('SUPABASE_URL') ?? '',
      // Supabase API ANON KEY - env var exported by default.
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      // Create client with Auth context of the user that called the function.
      // This way your row-level-security (RLS) policies are applied.
      { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
    )

    const {
      data: { user },
    } = await supabaseClient.auth.getUser()

    console.log(user)
    if (!user) {
      return new Response(JSON.stringify({ error: 'User not connected', error_code: 'user-not-connected' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      })
    }
    //get content from request body
    const body = await req.json()
    console.log(body)
    if (!body) {
      return new Response(JSON.stringify({ error: 'No body', error_code: 'no-body' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      })
    }
    // const user = {
    //   id: '3bfb2bd0-492b-4c6f-bf19-1e01481e1caf',
    // }
    // const body = {
    //   salary: 1000,
    //   firstname: "douglas",
    //   lastname: "le_bg",
    //   age: 23,
    //   skills: ['Dart']
    //   //skills: ['Java']
    // }

    let salary = body.salary
    let firstname = body.firstname
    let lastname = body.lastname
    let age = body.age
    let skills = body.skills
    //const USER_ID_TEST = '5f99a26d-d0a3-4bb0-b028-039b43ce9388'
    const { data, error } = await supabaseClient.from('jobseeker').update({
      'salary': salary,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
    }).eq('id', user.id)

    let skillsToAdd = [] as string[]
    // get all users skills
    const { data: userSkills, error: userSkillsError } = await supabaseClient.from('userskill').select('*').eq('userid', user.id)
    if (userSkillsError) throw userSkillsError
    console.log("userSkills len" + userSkills.length)


    //iteraty over skills
    for (let i = 0; i < skills.length; i++) {
      console.log("Inside the loop with skills: " + skills[i])
      // check if skill exists
      const { data: userSkillsData, error } = await supabaseClient.from('userskill').select('*').eq('skill', skills[i]).eq('userid', user.id)
      if (error) throw error
      console.log("userSkillsData: " + userSkillsData)
      console.log("userSkillsData len: " + userSkillsData.length)
      skillsToAdd.push(skills[i])

    }
    console.log("skillsToAdd: " + skillsToAdd)
    for (let i = 0; i < userSkills.length; i++) {
      if (!skillsToAdd.includes(userSkills[i].skill)) {
        // remove the skill using supabaseClient
        console.log("removing skill: " + userSkills[i].skill)
        const response = await supabaseClient.from('userskill').delete().eq('skill', userSkills[i].skill).eq('userid', user.id)
        if (response.error) throw response.error
      }
    }

    // we add the skills to the user
    for (let i = 0; i < skillsToAdd.length; i++) {
      // get the element with maximum id
      const { data: maxIdData, error: maxIdError } = await supabaseClient.from('userskill').select('id', { count: 'exact' }).order('id', { ascending: false }).limit(1)
      if (maxIdError) throw maxIdError
      console.log("maxIdData: " + maxIdData)
      const { res, error2 } = await supabaseClient.from('userskill').insert(
        { 'skill': skillsToAdd[i], 'userid': user.id, 'id': maxIdData + 1 }
      )
    }

    if (error) throw error

    const contents = data

    // prints out the contents of the users table
    console.log(contents)

    return new Response(JSON.stringify({ 'success': 200 }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    console.error(error)

    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
