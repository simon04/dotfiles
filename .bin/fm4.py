"""Fetches the currently playing FM4 track from orf.at"""
import requests

url = 'https://audioapi.orf.at/fm4/api/json/current/live'
live = requests.get(url).json()
tracks = live[0]['items']
track_now = [i for i in tracks if i['state'] == 'P'][0]

if 'interpreter' in track_now:
    print('FM4:', track_now['interpreter'], '–', track_now['title'])
else:
    print('FM4:', track_now['title'])
