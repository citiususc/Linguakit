# -*- coding: utf8 -*-
import requests
import json
import sys


url = "http://127.0.0.1:3002/v2.0/tagger"
headers = {"Content-Type": "application/json; charset=UTF-8"}
data = {"text": "Esta é unha foto de Santiago de Compostela.", "output": "nec"}

try:
    response = requests.post(url, json=data, headers=headers)
except Exception as e:
    print(f"Request failed: {e}")
    sys.exit(1)

for token in response.json():
    print(token)
