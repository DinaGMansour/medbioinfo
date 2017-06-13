#!/usr/bin/python
import sys
import string

fin = sys.argv[1] 
words = []
Seq = ''



for line in fin:
    word = string.split(line)
    words += word
    Length = len(words)      
    name = 'SEQ_1'
    Seq += line

print 'Length {}\n{}{}\n{}'.format(Length,">", name,Seq)