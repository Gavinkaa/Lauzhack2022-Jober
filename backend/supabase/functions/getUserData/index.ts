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
    // //const uuid = "3bfb2bd0-492b-4c6f-bf19-1e01481e1caf"
    // const uuid = "4490a5af-49f1-487b-ad7c-825535f79375"
    // const user: User = { id: uuid };
    //----------------------------------------

    const { data: received, error } = await supabaseClient.from('jobseeker').select('email, id, salary,firstname, lastname, age, userskill(skill), userlevel(level), userlocation(country, postalcode)').eq('id', user.id)
    if (error) throw error
    let data = received
    if (received.length !== 0) {
      data = received[0]
    }
    //read the email from data
    //put all the skills in a single array and keep only second element of each object
    let skills = {}
    if (data.userskill) {
      if (data.userskill.length === 0) {
        skills = []
      } else {
        skills = data.userskill[0]
        // transform the object into an array
        skills = Object.keys(skills).map(function (key) {
          return skills[key];
        });
      }
    }
    else {
      skills = []
    }
    let level = ""
    if (data.userlevel) {
      if (data.userlevel.length !== 0) {
        level = data.userlevel[0]
        level = Object.keys(level).map(function (key) {
          return level[key];
        })[0];
      }
    }
    let location = {}
    if (data.userlocation) {
      location = data.userlocation
    } else {
      location = {}
    }




    const contents = {
      location: location,
      level: level,
      skills: skills,
      user_id: data.id,
      email: data.email,
      salary: data.salary,
      firstname: data.firstname,
      lastname: data.lastname,
      age: data.age,
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
