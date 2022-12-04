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
    //const USER_EMAIL_TEST = 'robertobrown@example.net'
    const { data, error } = await supabaseClient.from('jobseeker').update({
      'salary': salary,
      'firstname': firstname,
      'lastname': lastname,
      'age' : age,
    }).eq('email', user.email)
    
    
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