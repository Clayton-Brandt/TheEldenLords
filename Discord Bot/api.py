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