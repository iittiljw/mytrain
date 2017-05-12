#coding:utf8

#############################
#
#ex20: 类
#
############################


class Student(object):
    def __init__(self,name,score):
        self.name = name
        self.score = score
    
    def print_scort(self):
        print '%s:%s' %(self.name,self.score)

bart=Student('Bart Simpson',45)
lisa=Student('Lisa comlis',54)

bart.print_scort()
lisa.print_scort()
