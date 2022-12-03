import os
import json
from dotenv import load_dotenv
from supabase import create_client, Client
from faker import Faker
import faker_commerce
import random

fake = Faker()
nSeeker = 10
n_jobs = 10
skills = ['Java', 'Flutter', 'Dart']
levels = ['Junior', 'Mid', 'Senior']
Location = ['Ch', 'USA', 'FR']
emails = [fake.email() for i in range(nSeeker)]
salaries = [fake.random_int(3000, 10000) for i in range(nSeeker)]
companies = ['Google', 'Facebook', 'Amazon', 'LauzHack']
jobIds = [i for i in range(n_jobs)]


# def add_entries_to_seeker_table(supabase, nb_of_seekers):
#    fake = Faker()
#    foreign_key_list = []
#    fake.add_provider(faker_commerce.Provider)
#    main_list = []
#    for i in range(nb_of_seekers):
#        value = {'email': fake.email(), 'salary': fake.random_int(40, 169)}
#        main_list.append(value)
#    data = supabase.table('jobseeker').insert(main_list).execute()
#    data_json = json.loads(data.json())
#    data_entries = data_json['data']
#    print(data_entries)
#    return

def add_entries_to_seeker_table(supabase):
    for i in range(nSeeker):
        supabase.table('jobseeker').insert(
            {'email': emails[i], 'salary': salaries[i]}).execute()


def add_entries_to_skill_table(supabase):
    for skill in skills:
        supabase.table('skill').insert({'skill': skill}).execute()


def add_entries_to_level_table(supabase):
    for level in levels:
        supabase.table('level').insert({'level': level}).execute()


def add_entries_to_location_table(supabase):
    for location in Location:
        supabase.table('location').insert({'location': location}).execute()


def add_entries_to_company_table(supabase):
    # iterate over companies and select a random location
    for company in companies:
        location = random.choice(Location)
        supabase.table('company').insert(
            {'name': company, 'location': location}).execute()


def add_entries_to_job_table(supabase):
    for i in range(n_jobs):
        company = random.choice(companies)
        location = random.choice(Location)
        supabase.table('job').insert({'jobid': i, 'company': company,
                                      'name': "name", 'location' : location}).execute()

# -------------- relational tables ----------------


def add_entries_to_userskill_table(supabase):
    count = 0
    for _, email in enumerate(emails):
        # create a set of random skills between 1 and 3
        _skills = random.sample(skills, random.randint(1, 3))
        for _, skill in enumerate(_skills):
            supabase.table('userskill').insert(
                {'email': email, 'skill': skill, 'id' : count}).execute()
            count += 1


def add_entries_to_userslevel_table(supabase):
    for email in emails:
        level = random.choice(levels)
        supabase.table('userlevel').insert(
            {'email': email, 'level': level}).execute()


def add_entries_to_userslocation_table(supabase):
    for email in emails:
        location = random.choice(Location)
        supabase.table('userlocation').insert(
            {'email': email, 'location': location}).execute()


def add_entries_to_jobskill_table(supabase):
    for job_id in jobIds:
        _skills = random.sample(skills, random.randint(1, 3))
        for skill in _skills:
            supabase.table('jobskill').insert(
                {'jobid': job_id, 'skill': skill}).execute()


def add_entries_to_joblevel_table(supabase):
    for job_id in jobIds:
        level = random.choice(levels)
        supabase.table('joblevel').insert(
            {'jobid': job_id, 'level': level}).execute()


def add_entries_to_joblocation_table(supabase):
    for job_id in jobIds:
        location = random.choice(Location)
        supabase.table('joblocation').insert(
            {'jobid': job_id, 'location': location}).execute()


def main():
    number_of_seekers = 10
    load_dotenv()
    url: str = os.environ.get('SUPABASE_URL')
    key: str = os.environ.get('SUPABASE_KEY')
    supabase: Client = create_client(url, key)
    add_entries_to_seeker_table(supabase)
    # add all the entries
    add_entries_to_skill_table(supabase)
    add_entries_to_level_table(supabase)
    add_entries_to_location_table(supabase)

    add_entries_to_company_table(supabase)
    add_entries_to_job_table(supabase)
    add_entries_to_userskill_table(supabase)
    
    add_entries_to_userslevel_table(supabase)
    add_entries_to_userslocation_table(supabase)
    add_entries_to_jobskill_table(supabase)
    add_entries_to_joblevel_table(supabase)
    add_entries_to_joblocation_table(supabase)

if __name__ == '__main__':
    main()
