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
    if(!user) {
      return new Response(JSON.stringify({ error: 'User not connected', error_code : 'user-not-connected' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      })
    }
    // get content from request body
    const body = await req.json()
    console.log(body)
    if(!body) {
      return new Response(JSON.stringify({ error: 'No body', error_code : 'no-body' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      })
    }
    let salary = body.salary
    let firstname = body.firstname
    let lastname = body.lastname
    let age = body.age
    let skills = body.skills
    const USER_ID_TEST = 'dc52141d-892e-4928-9c15-db593d1cb6b6'
    const { data, error } = await supabaseClient.from('jobseeker').update({
      'salary': salary,
      'firstname': firstname,
      'lastname': lastname,
      'age' : age,
    }).eq('id', user.id)
    
    // iteraty over skills
    for (let i = 0; i < skills.length; i++) {
      // check if skill exists
      const { data, error } = await supabaseClient.from('userskill').select('*').eq('skill', skills[i]).eq('userid', user.id)
      //if not exists, create it
      if (data.length == 0) {
        // get largest id from skills table 
        const { largest, error1 } = await supabaseClient.from('userskill').select('id', { count: 'exact' })
        const { data, error2 } = await supabaseClient.from('userskill').insert(
          { 'name': skills[i], 'userid': user.id, 'id' : largest + 1 }
        )
      }
    }
    
    if (error) throw error

    const contents = data

    // prints out the contents of the users table
    console.log(contents)

    return new Response('Ok', {
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