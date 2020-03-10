#!/usr/bin/python

import os
import sys
import glob

if len(sys.argv)<=4:
	print("arguments missing")
	sys.exit()

vfolder = sys.argv[1]
vext = sys.argv[2]
vname = sys.argv[3]
vleadzero = int(sys.argv[4])

fpattern = vfolder + "*." + vext
fname = sorted(glob.glob(fpattern))
print(type(fname))

num = 1
for i in fname:
	strnum = str(num).zfill(vleadzero)
	newname = "%s/%s_%s.%s" % (vfolder,vname,strnum,vext)
	os.rename(i,newname)
	num = num + 1
