import os
import json
from dotenv import load_dotenv
from supabase import create_client, Client
from faker import Faker
import faker_commerce


def add_entries_to_seeker_table(supabase, nb_of_seekers):
    fake = Faker()
    foreign_key_list = []
    fake.add_provider(faker_commerce.Provider)
    main_list = []
    for i in range(nb_of_seekers):
        value = {'email': fake.email(), 'salary': fake.random_int(40, 169)}
        main_list.append(value)
    data = supabase.table('jobseeker').insert(main_list).execute()
    data_json = json.loads(data.json())
    data_entries = data_json['data']
    print(data_entries)
    return

def add_entries_to_skill_table(supabase):
    pass

def main():
    number_of_seekers = 10
    load_dotenv()
    url: str = os.environ.get('SUPABASE_URL')
    key: str = os.environ.get('SUPABASE_KEY')
    supabase: Client = create_client(url, key)
    add_entries_to_seeker_table(supabase, number_of_seekers)


if __name__ == '__main__':
    main()
