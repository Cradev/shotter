#!/usr/bin/env python3

import argparse
import json
import os
import subprocess
import requests

def pbcopy(link_to_copy):
    ''' Copy the URL to the macOS clipboard. '''
    ps = subprocess.Popen(('echo', link_to_copy), stdout=subprocess.PIPE)
    output = subprocess.check_output(('pbcopy', 'process_name'), stdin=ps.stdout)
    ps.wait()

def upload(file):
    ''' Upload the image '''
    files = {
        'file': open(file, 'rb')
    }

    r = requests.post("http://scrn.me/uploader.php", data={'token': 'CHANGE ME'}, files=files)

    json_string = json.loads(r.text)
    pbcopy(json_string['public_url'])

def main():
    parser = argparse.ArgumentParser(description='Take file name')
    parser.add_argument('-f', help='file path for the file to upload', required=True)
    parser.add_argument('-d', help='delete file after upload.', action="store_true")
    args = parser.parse_args()
    file = args.f

    if args.d:
        upload(file)
        os.remove(file)

    else:
        upload(file)

main()

