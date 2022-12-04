// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.131.0/http/server.ts"
import {createClient} from "@supabase/supabase-js";

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

      await supabaseClient.from('')
    }


  const { name } = await req.json()
  const data = {
    message: `Hello ${name}!`,
  }

  return new Response(
    JSON.stringify(data),
    { headers: { "Content-Type": "application/json" } },
  )
})

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
