#! /usr/bin/env python
# -*- coding: utf-8 -*-
#======================================================================
#
# chatgpt.py - 
#
# Created by skywind on 2024/02/08
# Last Modified: 2024/02/08 21:41:55
#
#======================================================================
import sys
import time
import os


#----------------------------------------------------------------------
# 
#----------------------------------------------------------------------
def chatgpt_request(messages, apikey, opts):
    import urllib
    import urllib.request
    import json
    import io
    url = opts.get('url', "https://api.openai.com/v1/chat/completions")
    proxy = opts.get('proxy', None)
    timeout = opts.get('timeout', 20000)
    d = {'messages': messages}
    d['model'] = opts.get('model', 'gpt-3.5-turbo')
    d['stream'] = opts.get('stream', False)
    handlers = []
    if proxy:
        p = {'http': proxy, 'https': proxy}
        proxy_handler = urllib.request.ProxyHandler(p)
        handlers.append(proxy_handler)
    opener = urllib.request.build_opener(*handlers)
    req = urllib.request.Request(url, data = json.dumps(d).encode('utf-8'))
    req.add_header("Content-Type", "application/json")
    req.add_header("Accept", "text/event-stream")
    req.add_header("Authorization", "Bearer %s"%apikey)
    response = opener.open(req, timeout = timeout)
    bio = io.BytesIO()
    eof = False
    while not eof:
        r = response.read(4096)
        if not r:
            eof = True
            break
        bio.write(r)
    response.close()
    data = bio.getvalue()
    text = data.decode('utf-8', errors = 'ignore')
    return json.loads(text)


#----------------------------------------------------------------------
# 
#----------------------------------------------------------------------
def http_request(url, data = None, header = {}, proxy = None, timeout = 15):
    import urllib
    import urllib.request
    import json
    import io
    handlers = []
    if proxy:
        p = {'http': proxy, 'https': proxy}
        proxy_handler = urllib.request.ProxyHandler(p)
        handlers.append(proxy_handler)
    opener = urllib.request.build_opener(*handlers)
    req = urllib.request.Request(url, data = data)
    if header:
        for key in header:
            req.add_header(key, header[key])
    response = opener.open(req, timeout = timeout)
    return response.read()


#----------------------------------------------------------------------
# testing suit
#----------------------------------------------------------------------
if __name__ == '__main__':
    proxy = 'socks5h://127.0.0.1:1080'
    keyfile = '~/.config/openai/apikey.txt'
    apikey = open(os.path.expanduser(keyfile), 'r').read().strip('\r\n\t ')
    print(repr(apikey))
    def test1():
        p = 'socks5h://127.0.0.1:1080'
        u = 'https://www.google.com'
        t = http_request(u, proxy = None)
        print(t)
        return 0
    def test2():
        opts = {}
        opts['proxy'] = proxy
        query = 'hello'
        messages = []
        messages.append({"role": "user", "content": query})
        t = chatgpt_request(messages, apikey, opts)
        print(t)
        return 0
    test2()

