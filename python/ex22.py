#coding:utf8


###############################
#
#  ex22: 类 
#
###############################



class song(object):
    def __init__(self,lyrics):
        self.lyrics = lyrics
    def sing_me_a_song(self):
        for line in self.lyrics:
            print line
happy_bday = song(["Happy birthday to you","I don't want to get sued","So I'll stop right there"])

bulls_on_parade = song(["They rally around the family",
                        "with pockets full of shells"])

print "-"*40
happy_bday.sing_me_a_song()
print "-"*40
bulls_on_parade.sing_me_a_song()
print "-"*40
