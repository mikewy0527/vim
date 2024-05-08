#! /usr/bin/env python
# -*- coding: utf-8 -*-
#======================================================================
#
# pkgdump.py - 
#
# Created by skywind on 2024/05/08
# Last Modified: 2024/05/08 15:02:44
#
#======================================================================
import sys
import os
import time
import ascmini


#----------------------------------------------------------------------
# configure
#----------------------------------------------------------------------
class configure (object):

    def __init__ (self, dirhome = None):
        self.pkg_config_path = None
        if not dirhome:
            dirhome = os.path.abspath('build')
        self.dirhome = dirhome
        self.package = {}
        self.__search()

    def __search (self):
        self.package = {}
        if not os.path.isdir(self.dirhome):
            return -1
        for fname in os.listdir(self.dirhome):
            extname = os.path.splitext(fname)[1]
            if extname.lower() != '.pc':
                continue
            path = os.path.normpath(os.path.join(self.dirhome, fname))
            pkg = {}
            name = os.path.splitext(fname)[0]
            pkg['path'] = path
            pkg['name'] = name
            self.package[name] = pkg
            print(pkg)
        return 0

    def pkgconfig (self, args):
        argv = ['pkg-config'] + args
        saved = os.environ.get('PKG_CONFIG_PATH', None)
        if self.pkg_config_path:
            os.environ['PKG_CONFIG_PATH'] = self.pkg_config_path
        text = ascmini.execute(argv, False, True)
        if self.pkg_config_path:
            if saved is not None:
                os.environ['PKG_CONFIG_PATH'] = saved
            elif 'PKG_CONFIG_PATH' in os.environ:
                del os.environ['PKG_CONFIG_PATH']
        if os.shell_return != 0:
            return None
        return ascmini.posix.string_auto_decode(text)


#----------------------------------------------------------------------
# testing suit
#----------------------------------------------------------------------
if __name__ == '__main__':
    def test1():
        config = configure('d:/dev/conan/mingw32/build')
        print(config.pkgconfig(['--cflags', 'zlib']))
        return 0
    test1()


