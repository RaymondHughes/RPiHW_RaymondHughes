#!/bin/usr/env python

import sys
rawtxt = sys.argv[1]

loc1 = rawtxt.find("id")
idle = rawtxt[loc1-6:loc1-1]

loc2 = rawtxt.find("wa")
wait = rawtxt[loc2-6:loc2-1]

txt = str(100 - float(idle) - float(wait))

print(txt)
