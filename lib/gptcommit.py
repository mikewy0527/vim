#! /usr/bin/env python
# -*- coding: utf-8 -*-
#======================================================================
#
# gptcommit.py - 
#
# Created by skywind on 2024/02/11
# Last Modified: 2024/02/11 21:57:31
#
#======================================================================
import sys
import time
import os


#----------------------------------------------------------------------
# request chatgpt
#----------------------------------------------------------------------
def chatgpt_request(messages, apikey, opts):
    import urllib, urllib.request, json
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
    req.add_header("Authorization", "Bearer %s"%apikey)
    # req.add_header("Accept", "text/event-stream")
    response = opener.open(req, timeout = timeout)
    data = response.read()
    response.close()
    text = data.decode('utf-8', errors = 'ignore')
    return json.loads(text)


#----------------------------------------------------------------------
# load ini
#----------------------------------------------------------------------
def load_ini(filename, encoding = None):
    if '~' in filename:
        filename = os.path.expanduser(filename)
    content = open(filename, 'r', encoding = encoding).read()
    config = {}
    for line in content.split('\n'):
        line = line.strip('\r\n\t ')
        # pylint: disable-next=no-else-continue
        if not line:   # noqa
            continue
        elif line[:1] in ('#', ';'):
            continue
        elif line.startswith('['):
            if line.endswith(']'):
                sect = line[1:-1].strip('\r\n\t ')
                if sect not in config:
                    config[sect] = {}
        else:
            pos = line.find('=')
            if pos >= 0:
                key = line[:pos].rstrip('\r\n\t ')
                val = line[pos + 1:].lstrip('\r\n\t ')
                if sect not in config:
                    config[sect] = {}
                config[sect][key] = val
    return config


#----------------------------------------------------------------------
# lazy request
#----------------------------------------------------------------------
LAZY_OPTION = None
LAZY_CONFIG = '~/.config/gptcommit.ini'

def chatgpt_lazy(messages):
    global LAZY_OPTION
    if LAZY_OPTION is None:
        LAZY_OPTION = load_ini(LAZY_CONFIG)
        if 'default' not in LAZY_OPTION:
            LAZY_OPTION['default'] = {}
    option = LAZY_OPTION['default']
    apikey = option.get('apikey', '').strip('\r\n\t ')
    proxy = option.get('proxy', '').strip('\r\n\t ')
    if not apikey:
        raise KeyError('apikey is not provided')
    opts = {}
    if proxy:
        opts['proxy'] = proxy
    if 'model' in option:
        opts['model'] = option['model']
    return chatgpt_request(messages, apikey, opts)


#----------------------------------------------------------------------
# testing suit
#----------------------------------------------------------------------
if __name__ == '__main__':
    def test1():
        import json
        msgs = json.load(open('d:/temp/diff.log'))
        print(msgs)
        t = chatgpt_lazy(msgs)
        print(t)
        return 0
    test1()



