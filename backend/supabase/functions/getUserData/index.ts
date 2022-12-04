import { serve } from 'https://deno.land/std@0.131.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': '*',
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
    //-- used for debugging without flutter
    // define a user struct
    // interface User {
    //   id: string;
    // }
    // const uuid = "3bfb2bd0-492b-4c6f-bf19-1e01481e1caf"
    // const user: User = { id: uuid };
    //----------------------------------------

    const { data, error } = await supabaseClient.from('jobseeker').select('email, id, salary,firstname, lastname, age, userskill(skill), userlevel(level), userlocation(country, postalcode)').eq('id', user.id)
    if (error) throw error
    // read the email from data
    // put all the skills in a single array and keep only second element of each object
    let skills = data.map(({ userskill }) => userskill).flat().map(({ skill }) => skill)
    skills = skills ? skills : []
    // put all the levels in a single array and keep only second element of each object
    let level = data.map(({ userlevel }) => userlevel).flat().map(({ level }) => level)
    level = level ? level : ""
    // put all the locations in a single array and keep only second element of each object
    let location = data.map(({ userlocation }) => userlocation).flat().map(({ country, postalcode }) => ({ country, postalcode }))[0]
    // combine all data into one object
    // if location has length 0, create empty dictionary
    location = location ? location : {}


    const contents = {
      user_id: data[0].id,
      email: data[0].email,
      salary: data[0].salary,
      firstname: data[0].firstname,
      lastname: data[0].lastname,
      age: data[0].age,
      skills: skills,
      level: level,
      location: location
    }

    return new Response(JSON.stringify(contents), {
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
