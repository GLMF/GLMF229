import sys
import os
from random import randint
from playsound import playsound


DIR_SOUNDS='/home/login/bin/data/sonorize'

if __name__ == '__main__':
    nbFiles = len(os.listdir(DIR_SOUNDS))
    alea = str(randint(1, nbFiles))
    filename = DIR_SOUNDS + '/' + sys.argv[1] + '/' + sys.argv[2] + '/' + sys.argv[2] + '_' + alea + '.wav'
    playsound(filename)
