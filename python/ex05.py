# -*- coding:utf8 -*-

###########
#
#ex05:while语句
#
############


i = 1
k = 1

while i <= 9:
    while k<= i:
        print i,'*',k,'=',k*i,"\t",
        k += 1
    print ""
    k = 1
    i +=1
