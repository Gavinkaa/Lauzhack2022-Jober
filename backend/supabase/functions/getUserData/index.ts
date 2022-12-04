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
    //define a user struct
    // interface User {
    //   id: string;
    // }
    // const uuid = "5f99a26d-d0a3-4bb0-b028-039b43ce9388"

    // // create a User instance with email
    // const user: User = { id: uuid };
    //const { data, error } = await supabaseClient.from('jobseeker').select('email, userskill(skill)').eq('email', user.email)
    //const { user_data, user_error } = await supabaseClient.from('jobseeker').select('id, userskill(skill), userlevel(level), userlocation(country, postalcode)').eq('id', user.id)
    //if (user_error) throw user_error
    //console.log("user data:" + user_data)
    // put the data into a variable
    //if (user_error) throw user_error
    const { data, err } = await supabaseClient.from('jobseeker').select('email, id, salary,firstname, lastname, age, userskill(skill), userlevel(level), userlocation(country, postalcode)').eq('id', user.id)
    if (err) throw err
    //console.log(res2.data)
    // read the email from data
    // put all the skills in a single array and keep only second element of each object
    const skills = data.map(({ userskill }) => userskill).flat().map(({ skill }) => skill)
    // put all the levels in a single array and keep only second element of each object
    const levels = data.map(({ userlevel }) => userlevel).flat().map(({ level }) => level)
    // put all the locations in a single array and keep only second element of each object
    const locations = data.map(({ userlocation }) => userlocation).flat().map(({ country, postalcode }) => ({ country, postalcode }))
    // combine all data into one object
    const contents = {
      //data: data.map(({ email, id, salary, firstname, lastname, age }) => ({ email, id, salary, firstname, lastname, age })),
      user_id: data[0].id,
      email: data[0].email,
      salary: data[0].salary,
      firstname: data[0].firstname,
      lastname: data[0].lastname,
      age: data[0].age,
      skills: skills,
      level: levels[0],
      location: locations[0]
    }

    return new Response(JSON.stringify(contents), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })









    // const contents = data

    // prints out the contents of the users table
    // console.log(contents)

    //return new Response(JSON.stringify({ contents }), {
    //  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    //  status: 200,
    //})
  } catch (error) {
    console.error(error)

    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})
