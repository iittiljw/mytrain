#coding:utf8


##############################
#
#  ex06: File练习
#
##############################

print ""
print "#"*20
print ""

file = open("aa",'r')
print file.read()
file.close()
print "#"*20

with open('aa','r') as f:
    for line in f.readlines():
        print (line.strip())

print ""
print "#"*20
print ""



file1 = open('aa','r')
for line in file1.readlines():
    print line.strip()
file1.close()

print ""
print "#"*20
print ""
