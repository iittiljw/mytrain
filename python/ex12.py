#envcoding:utf-8

###########################
#
#ex12：函数练习3
#
##########################

def add(a,b):
    print "ADDING %d + %d:" %(a,b)
    return a + b

def subtract(a,b):
    print "SUBTRACTING %d + %d:" % (a,b)
    return a - b

def multiply(a,b):
    print "MULTIPLYING %d * %d:" % (a,b)
    return a * b

def divide(a,b):
    print "DEVIDING %d / %d:" % (a,b)
    return a / b

print "Let's do some math with just functons!"

age = add(30,5)
height = subtract(78,4)
weight = multiply(90,2)
iq = divide(100,2)


print "AGE: %d, Height: %d, Weight: %d, IQ: %d." % (age,height,weight,iq)

