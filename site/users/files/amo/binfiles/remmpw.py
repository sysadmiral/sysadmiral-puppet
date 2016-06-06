#!/usr/bin/python

import base64
from Crypto.Cipher import DES3

secret = base64.decodestring('2x2X7sgphyw/K9CM6LSGQASgmWFAtKWkAA4+oP7bBdk=')
password = base64.decodestring('/6g3lrMTok3Dp2HV++g0lg==')

print DES3.new(secret[:24], DES3.MODE_CBC, secret[24:]).decrypt(password)
