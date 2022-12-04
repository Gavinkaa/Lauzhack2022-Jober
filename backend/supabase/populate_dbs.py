import os
import json
from dotenv import load_dotenv
from supabase import create_client, Client
from faker import Faker
import faker_commerce
import random
import uuid

fake = Faker()
# nSeeker = 10
nSeeker = 1
n_jobs = 6
users_uuid = ['3bfb2bd0-492b-4c6f-bf19-1e01481e1caf']
# users_uuid = ['dc52141d-892e-4928-9c15-db593d1cb6b6',
#              '94af9887-41ae-4544-8a54-6d65a07e836d', '6ed55cde-0ac9-4bad-a7ed-b760531d599b']
skills = ['Java', 'Flutter', 'Dart']
levels = ['Junior', 'Mid', 'Senior']
job_names = ['developer', 'engineer', 'consultant', 'analyst']
Location = ['Ch', 'USA', 'FR']
country = 'CH'
postalCodes = [i for i in range(1000, 1004)]
emails = [fake.email() for _ in range(nSeeker)]
names = [fake.name() for _ in range(nSeeker)]
ages = [random.randint(18, 60) for _ in range(nSeeker)]
# create fake users name list using faker
salaries = [fake.random_int(3000, 10000) for i in range(nSeeker)]
companies = ['Google', 'Facebook', 'Amazon', 'LauzHack']
jobIds = [i for i in range(n_jobs)]


def add_entries_to_seeker_table(supabase):
    for i in range(nSeeker):
        firstname = names[i].split(' ')[0]
        lastname = names[i].split(' ')[1]
        supabase.table('jobseeker').insert(
            {'id': users_uuid[i], 'email': emails[i], 'salary': salaries[i], 'firstname': firstname, 'lastname': lastname, 'age': ages[i]}).execute()


def add_entries_to_skill_table(supabase):
    for skill in skills:
        supabase.table('skill').insert({'skill': skill}).execute()


def add_entries_to_level_table(supabase):
    for level in levels:
        supabase.table('level').insert({'level': level}).execute()


def add_entries_to_location_table(supabase):
    # only generate location for Switzerland atm
    for postalCode in postalCodes:
        supabase.table('location').insert(
            {'country': country, 'postalcode': postalCode}).execute()


def add_entries_to_company_table(supabase):
    # iterate over companies and select a random location
    for _id, company in enumerate(companies):
        postalCode = random.choice(postalCodes)
        supabase.table('company').insert(
            {'id': _id, 'name': company, 'country': country, 'postalcode': postalCode}).execute()
        # {'name': company, 'location': location}).execute()


def add_entries_to_job_table(supabase):
    for i in range(n_jobs):
        # select a random number between 0 and len(companies)
        company_id = random.randint(0, len(companies)-1)
        # select a random element from levels
        level = random.choice(levels)
        job_name = random.choice(job_names)
        postalCode = random.choice(postalCodes)
        supabase.table('job').insert({'jobid': i, 'companyid': company_id,
                                      'name': job_name, 'country': country, 'postalcode': postalCode, 'level': level}).execute()

# -------------- relational tables ----------------


def add_entries_to_userskill_table(supabase):
    for uuid in users_uuid:
        # create a set of random skills between 1 and 3
        _skills = random.sample(skills, random.randint(1, 3))
        for skill in _skills:
            supabase.table('userskill').insert(
                {'userid': uuid, 'skill': skill}).execute()


def add_entries_to_userslevel_table(supabase):
    for uuid in users_uuid:
        level = random.choice(levels)
        supabase.table('userlevel').insert(
            {'userid': uuid, 'level': level}).execute()


def add_entries_to_userslocation_table(supabase):
    for uuid in users_uuid:
        postalCode = random.choice(postalCodes)
        supabase.table('userlocation').insert(
            {'userid': uuid, 'country': country, 'postalcode': postalCode}).execute()


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
        postalCode = random.choice(postalCodes)
        supabase.table('joblocation').insert(
            {'jobid': job_id, 'country': country, 'postalcode': postalCode}).execute()


def main():
    number_of_seekers = 10
    load_dotenv()
    url: str = os.environ.get('SUPABASE_URL')
    key: str = os.environ.get('SUPABASE_KEY')
    supabase: Client = create_client(url, key)
    # add_entries_to_seeker_table(supabase)
    # add all the entries
    # add_entries_to_skill_table(supabase)
    # add_entries_to_level_table(supabase)
    # add_entries_to_location_table(supabase)

    # add_entries_to_company_table(supabase)
    # add_entries_to_job_table(supabase)
    # add_entries_to_userskill_table(supabase)

    # add_entries_to_userslevel_table(supabase)
    # add_entries_to_userslocation_table(supabase)
    # add_entries_to_jobskill_table(supabase)


if __name__ == '__main__':
    main()
