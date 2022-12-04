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
    //define a user struct
    interface User {
      id: string;
    }
    const uuid = "3bfb2bd0-492b-4c6f-bf19-1e01481e1caf"
    const user: User = { id: uuid };
    const jobid = 0


    // get all information in jobskill table for a given jobid
    const { data: jobSkills, error: jobSkillsError } = await supabaseClient
      .from('jobskill')
      .select('*')
    //.eq('jobid', jobid)

    // keep only the skill values from data
    //const jobSkillsValues = jobSkills?.map((jobSkill) => jobSkill.skill)
    const jobSkillsValues = jobSkills?.map((jobSkill) => {
      return { jobid: jobSkill.jobid, skills: jobSkill.skill }
    })

    const { data: jobLocation, error: jobLocationError } = await supabaseClient
      .from('joblocation')
      .select('*')
    //.eq('jobid', jobid)

    // put the country and ppostalcode values in a dictionary
    const jobLocationValues = jobLocation?.map((jobLocation) => {
      return { country: jobLocation.country, postalcode: jobLocation.postalcode }
    })

    const { data: jobLevel, error: jobLevelError } = await supabaseClient
      .from('joblevel')
      .select('*')
    //.eq('jobid', jobid)

    // keep only the level value from jobName
    const jobLevelValue = jobLevel?.map((jobLevel) => jobLevel.level)

    // get job name from job table
    const { data: jobName, error: jobNameError } = await supabaseClient
      .from('job')
      .select('name')
    //.eq('jobid', jobid)
    // keep only the name value from jobName
    const jobNameValue = jobName?.map((jobName) => jobName.name)

    // combine all data into one object
    const res = {
      skills: jobSkillsValues,
      location: jobLocationValues,
      name: jobNameValue,
      description: "Some random description",
      level: jobLevelValue
    }


    // join the job table with the jobskill table
    // const { data, error } = await supabaseClient
    //   .from('job')
    //   .select('jobid, jobskill(jobid)')
    if (jobSkillsError) throw jobSkillsError
    // log data as a json
    console.log(JSON.stringify(res))


    const contents = {
      user: user,
    }

    return new Response(JSON.stringify(res), {
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
