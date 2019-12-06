"""Fetches the currently playing FM4 track from orf.at"""
import requests

url = 'https://audioapi.orf.at/fm4/api/json/current/live'
live = requests.get(url).json()
tracks = live[0]['items']
tracks_now = [i for i in tracks if i['state'] == 'P']
if not tracks_now:
    print('FM4: –')
elif 'title' in tracks_now[0] and 'interpreter' in tracks_now[0]:
    print('FM4:', tracks_now[0]['interpreter'], '–', tracks_now[0]['title'])
elif 'title' in tracks_now[0]:
    print('FM4:', tracks_now[0]['title'])
else:
    print('FM4: –')
