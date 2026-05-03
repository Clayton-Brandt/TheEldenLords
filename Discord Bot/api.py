import requests

API_URL = "http://127.0.0.1:8000"

def get_all_bosses():
    response = requests.get(f"{API_URL}/bosses/", timeout=5)
    response.raise_for_status()
    return response.json()


def get_boss(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}", timeout=5)
    response.raise_for_status()
    return response.json()


def search_boss(name):
    response = requests.get(f"{API_URL}/bosses/", params={"name": name}, timeout=5)
    response.raise_for_status()
    return response.json()

def create_boss(name, location):
    payload = {
        "name": name,
        "location": location
    }

    response = requests.post(f"{API_URL}/bosses/", json=payload, timeout=5)
    response.raise_for_status()
    return response.json()

def delete_boss(boss_id):
    response = requests.delete(f"{API_URL}/bosses/{boss_id}", timeout=5)
    response.raise_for_status()
    return response.json()

def update_boss(boss_id, name, location):
    payload = {
        "name": name,
        "location": location
    }

    response = requests.put(
        f"{API_URL}/bosses/{boss_id}",
        json=payload,
        timeout=5
    )
    response.raise_for_status()
    return response.json()

def get_boss_lore(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/lore", timeout=5)
    response.raise_for_status()
    return response.json()

def get_boss_prerequisites(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/prerequisites", timeout=5)
    response.raise_for_status()
    return response.json()

def get_boss_stats(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/stats", timeout=5)
    response.raise_for_status()
    return response.json()

def get_boss_resistances(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/resistances", timeout=5)
    response.raise_for_status()
    return response.json()

def get_boss_weaknesses(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/weaknesses", timeout=5)
    response.raise_for_status()
    return response.json()

def get_boss_rewards(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/rewards", timeout=5)
    response.raise_for_status()
    return response.json()

def get_boss_help_links(boss_id):
    response = requests.get(f"{API_URL}/bosses/{boss_id}/help", timeout=5)
    response.raise_for_status()
    return response.json()



