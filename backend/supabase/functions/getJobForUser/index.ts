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
    //--used for debugging without flutter
    //define a user struct
    interface User {
      id: string;
    }
    const uuid = "3bfb2bd0-492b-4c6f-bf19-1e01481e1caf"
    const user: User = { id: uuid };
    //----------------------------------------

    // get all jobs skills
    const { data: jobSkills, error: jobskillserror } = await supabaseClient.from('jobskill').select('*')

    // group data by jobid
    const groupedByJobIdSkills = jobSkills.reduce((acc, obj) => {
      const key = obj.jobid;
      if (!acc[key]) {
        acc[key] = [];
      }
      acc[key].push(obj.skill);
      return acc;
    }, {});

    // give type to groupedByJobIdSkills
    interface GroupedByJobIdSkills {
      [key: string]: string[];
    }

    // get all the skills of the user
    const { data: userskills, error: userSkillsError } = await supabaseClient.from('userskill').select('*').eq('userid', user.id).select('skill')
    if (userSkillsError) {
      return new Response(JSON.stringify({ error: userSkillsError, error_code: 'userSkillsError' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      })
    }

    // define an array of int
    let matchedJobs = [] as number[];
    // for each key in the groupedByJobIdSkills, if the user has all the skills, add the jobid to the matchedJobs array
    for (const key in groupedByJobIdSkills) {
      const element = groupedByJobIdSkills[key];
      if (element.every((val) => userskills.some((skill) => skill.skill === val))) {
        matchedJobs.push(parseInt(key));
      }
    }

    // get all the jobs with jobid in matchedJobs
    const { data: jobs, error: jobsError } = await supabaseClient.from('job').select('*').in('jobid', matchedJobs)
    if (jobsError) {
      return new Response(JSON.stringify({ error: jobsError, error_code: 'jobsError' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      })
    }

    // Let dataWithSkills be the map of data with a new key 'skills' that is an array of Strings
    const dataWithSkills = jobs.map((job) => {
      // Filter the jobData array to only include the skills for the current job
      const skills = jobSkills.filter((jobSkill) => jobSkill.jobid === job.jobid).map((jobSkill) => jobSkill.skill)
      // Return the job with the skills array
      return {
        ...job,
        skills
      }
    })

    //let data = dataWithSkills

    return new Response(JSON.stringify(dataWithSkills), {
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
