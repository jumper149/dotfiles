#!/bin/python

import numpy as np

from os.path import expanduser
homedir = expanduser("~/")

def red():
    ext_mins = np.loadtxt(homedir + '.config/i3/scripts/blugon/ext_gamma_from_time_red')
    
    all_mins = np.array([])
    
    for i in range(len(ext_mins)-1):
        appender = np.linspace(ext_mins[i][1], ext_mins[i+1][1], ext_mins[i+1][0] - ext_mins[i][0])
        all_mins = np.append(all_mins, appender)
        
    print(all_mins)
    
    np.savetxt(homedir + '.config/i3/scripts/blugon/gamma_from_mins_red', all_mins, fmt='%f')
    print(ext_mins)
    
    return 0
    
    
def green():
    ext_mins = np.loadtxt(homedir + '.config/i3/scripts/blugon/ext_gamma_from_time_green')
    
    all_mins = np.array([])
    
    for i in range(len(ext_mins)-1):
        appender = np.linspace(ext_mins[i][1], ext_mins[i+1][1], ext_mins[i+1][0] - ext_mins[i][0])
        all_mins = np.append(all_mins, appender)
        
    print(all_mins)
    
    np.savetxt(homedir + '.config/i3/scripts/blugon/gamma_from_mins_green', all_mins, fmt='%f')
    print(ext_mins)
    
    return 0
    
    
def blue():
    ext_mins = np.loadtxt(homedir + '.config/i3/scripts/blugon/ext_gamma_from_time_blue')
    
    all_mins = np.array([])
    
    for i in range(len(ext_mins)-1):
        appender = np.linspace(ext_mins[i][1], ext_mins[i+1][1], ext_mins[i+1][0] - ext_mins[i][0])
        all_mins = np.append(all_mins, appender)
        
    print(all_mins)
    
    np.savetxt(homedir + '.config/i3/scripts/blugon/gamma_from_mins_blue', all_mins, fmt='%f')
    print(ext_mins)
    
    return 0


def main():
    
    red()
    green()
    blue()
    
    return 0

if __name__=="__main__":
    main()
