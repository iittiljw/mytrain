#envcoding: utf-8


###########################
#
#ex14：猜数字
#
##########################



import random
random_num = random.randint(0,100)

count = 0

while count <= 5:
    num = int(input("请输入一个整数:"))
    count += 1
    if num > random_num:
        print("太大")
        continue 
    elif num < random_num:
        print("太小") 
        continue 
    else:
        print("ok")
        break 
else:
    print("你太笨了，下次再来！！")
