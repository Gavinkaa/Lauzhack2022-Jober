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

    // const {
    //   data: { user },
    // } = await supabaseClient.auth.getUser()

    // console.log(user)
    // if (!user) {
    //   return new Response(JSON.stringify({ error: 'User not connected', error_code: 'user-not-connected' }), {
    //     headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    //     status: 400,
    //   })
    // }
    // //get content from request body
    // const body = await req.json()
    // console.log(body)
    // if (!body) {
    //   return new Response(JSON.stringify({ error: 'No body', error_code: 'no-body' }), {
    //     headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    //     status: 400,
    //   })
    // }

    // let salary = body.salary
    // let firstname = body.firstname
    // let lastname = body.lastname
    // let age = body.age
    // let skills = body.skills
    // //const USER_ID_TEST = '5f99a26d-d0a3-4bb0-b028-039b43ce9388'
    // const { data, error } = await supabaseClient.from('jobseeker').update({
    //   'salary': salary,
    //   'firstname': firstname,
    //   'lastname': lastname,
    //   'age': age,
    // }).eq('id', user.id)

    const user = {
      id: '3bfb2bd0-492b-4c6f-bf19-1e01481e1caf',
    }
    const body = {
      salary: 1000,
      firstname: "douglas",
      lastname: "le_bg",
      age: 23,
      skills: ['Dart'],
      location: { country: 'CH', postalCode: 1001 },
      level: 'Senior'
    }


    // add the skill
    let skillsToAdd = [] as string[]
    // get all users skills
    const { data: userSkills, error: userSkillsError } = await supabaseClient.from('userskill').select('*').eq('userid', user.id)
    if (userSkillsError) throw userSkillsError
    //iteraty over skills
    for (let i = 0; i < body.skills.length; i++) {
      // check if skill exists
      const { data: userSkillsData, error } = await supabaseClient.from('userskill').select('*').eq('skill', body.skills[i]).eq('userid', user.id)
      if (error) throw error
      skillsToAdd.push(body.skills[i])

    }
    for (let i = 0; i < userSkills.length; i++) {
      if (!skillsToAdd.includes(userSkills[i].skill)) {
        // remove the skill using supabaseClient
        const response = await supabaseClient.from('userskill').delete().eq('skill', userSkills[i].skill).eq('userid', user.id)
        if (response.error) throw response.error
      }
    }

    // we add the skills to the user
    for (let i = 0; i < skillsToAdd.length; i++) {
      // get the element with maximum id
      const { data: maxIdData, error: maxIdError } = await supabaseClient.from('userskill').select('id', { count: 'exact' }).order('id', { ascending: false }).limit(1)
      if (maxIdError) throw maxIdError
      // convert maxIdData to number
      let maxId = 0
      if (maxIdData.length > 0) {
        maxId = parseInt(maxIdData[0].id) + 1
      }
      const { res, error2 } = await supabaseClient.from('userskill').insert(
        { 'skill': skillsToAdd[i], 'userid': user.id, 'id': maxId }
      )
    }

    //------------------handling the user's location------------------
    // check if body contains a field called location
    if (body.location) {
      // In that case we just update the location
      const location = body.location
      const country = location.country
      const postalCode = location.postalCode
      // we can just update the location in database for the user
      const { data: locationData, error: locationError } = await supabaseClient.from('userlocation').update({ 'country': country, 'postalcode': postalCode }).eq('userid', user.id)
      if (locationError) throw locationError
    }
    // ------------------handling of user's level------------------
    // check if body contains a field called level
    if (body.level) {
      // In that case we just update the level
      const { data: levelData, error: levelError } = await supabaseClient.from('userlevel').update({ 'level': body.level }).eq('userid', user.id)
      if (levelError) throw levelError
    }



    return new Response(JSON.stringify({ 'success': 200 }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
  catch (error) {
    console.error(error)

    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
