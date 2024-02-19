#! /usr/bin/env python
# -*- coding: utf-8 -*-
#======================================================================
#
# gptcoder.py - 
#
# Created by skywind on 2024/02/19
# Last Modified: 2024/02/19 21:45:51
#
#======================================================================
import sys
import time
import os


#----------------------------------------------------------------------
# configure
#----------------------------------------------------------------------
class configure (object):

    def __init__ (self, ininame):
        if ininame is None:
            ininame = '~/.config/gptcoder.ini'
        self.config = self.load_ini(self.ininame)
        if not self.config:
            self.config = {}
        if 'default' not in self.config:
            self.config['default'] = {}
        self.engine = self.config['default'].get('engine', '')
        self._initialize()

    # initialize
    def _initialize (self):
        return 0

    # auto detect encoding and decode into a string
    def string_auto_decode (self, payload, encoding = None):
        content = None
        if payload is None:
            return None
        if hasattr(payload, 'read'):
            try: content = payload.read()
            except: pass
        else:
            content = payload
        if sys.version_info[0] >= 3:
            if isinstance(content, str):
                return content
        else:
            # pylint: disable-next=else-if-used, undefined-variable
            if isinstance(content, unicode):   # noqa
                return content
        if content is None:
            return None
        if not isinstance(payload, bytes):
            return str(payload)
        if content[:3] == b'\xef\xbb\xbf':
            return content[3:].decode('utf-8', 'ignore')
        elif encoding is not None:
            return content.decode(encoding, 'ignore')
        guess = [sys.getdefaultencoding(), 'utf-8']
        if sys.stdout and sys.stdout.encoding:
            guess.append(sys.stdout.encoding)
        try:
            import locale
            guess.append(locale.getpreferredencoding())
        except:
            pass
        visit = {}
        text = None
        for name in guess + ['gbk', 'ascii', 'latin1']:
            if name in visit:
                continue
            visit[name] = 1
            try:
                text = content.decode(name)
                break
            except:
                pass
        if text is None:
            text = content.decode('utf-8', 'ignore')
        return text

    def load_file_content (self, filename, mode = 'r'):
        if hasattr(filename, 'read'):
            try: 
                return filename.read()
            except: 
                return None
        try:
            if '~' in filename:
                filename = os.path.expanduser(filename)
            fp = open(filename, mode)
            content = fp.read()
            fp.close()
        except:
            return None
        return content

    def load_file_text (self, filename, encoding = None):
        content = self.load_file_content(filename, 'rb')
        return self.string_auto_decode(content, encoding)

    # load ini without ConfigParser
    def load_ini (self, filename, encoding = None):
        text = self.load_file_text(filename, encoding)
        config = {}
        sect = 'default'
        if text is None:
            return None
        for line in text.split('\n'):
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

    def _chatgpt_request (self, messages, apikey, opts):
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

    def _ollama_request (self, messages, url, model, opts):
        import urllib, urllib.request, json
        proxy = opts.get('proxy', None)
        timeout = opts.get('timeout', 20000)
        d = {'model': model, 'messages': messages}
        d['stream'] = False
        handlers = []
        if proxy:
            p = {'http': proxy, 'https': proxy}
            proxy_handler = urllib.request.ProxyHandler(p)
            handlers.append(proxy_handler)
        opener = urllib.request.build_opener(*handlers)
        req = urllib.request.Request(url, data = json.dumps(d).encode('utf-8'))
        req.add_header("Content-Type", "application/json")
        response = opener.open(req, timeout = timeout)
        data = response.read()
        response.close()
        text = data.decode('utf-8', errors = 'ignore')
        return json.loads(text)


#----------------------------------------------------------------------
# 
#----------------------------------------------------------------------



#----------------------------------------------------------------------
# testing suit
#----------------------------------------------------------------------
if __name__ == '__main__':
    def test1():
        
        return 0
    test1()

