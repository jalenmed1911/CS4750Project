import requests

API_KEY = "Gl66ANUF8zNrf/3cvBMwigZ2xq88ZVkFdQCU8ak87tpS/yyjtag84JrIQFL06lqQ"
BASE_URL = "https://api.collegefootballdata.com/"

params = {
    "conference": "ACC",
    "year": 2025
}

headers = {
    "Authorization": f"Bearer {API_KEY}"
}

response = requests.get(BASE_URL, headers=headers, params=params)
data = response.json()

print(len(data))