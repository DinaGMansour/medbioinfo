#!/usr/bin/python
import sys
import string

fin = open (sys.argv[1], 'r')
id = []
NUMBER = ''



for line in fin:
    lines = line.rstrip('\n')
    if line[0] == '@':
       name = line
       name1 = name.replace("@", "")
       id.append(name1)
       
NUMBER = len(id)
print 'Number of Sequences {}'.format(NUMBER)
print ''.join(id)
