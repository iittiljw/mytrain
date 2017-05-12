#coding: utf8

#################################
#
#ex19:  闰年判断
#
#################################

year = int(input ("请输入年份："))

if year % 4 == 0 and year % 100 != 0:
    print ("闰年")
elif year % 400 == 0:
    print ("闰年")
else:
    print ("不是闰年")


