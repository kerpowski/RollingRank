# -*- coding: utf-8 -*-
"""
Created on Thu Jan 14 19:59:30 2016

@author: kerpowski
"""

from numpy cimport *
#cimport numpy as np
import numpy as np

cimport cython

cdef double NaN = <double> np.NaN

def _check_minp(win, minp, N):
    if minp > win:
        raise ValueError('min_periods (%d) must be <= window (%d)'
                        % (minp, win))
    elif minp > N:
        minp = N + 1
    elif minp < 0:
        raise ValueError('min_periods must be >= 0')
    return max(minp, 1)
    
    

def roll_rank(ndarray[float64_t, cast=True] input, 
              int win,
              int minp, 
              double threshold):
#    cdef double 
    cdef Py_ssize_t smaller = 0                         
    cdef Py_ssize_t larger = 0
    cdef Py_ssize_t equal = 0
    cdef Py_ssize_t nobs = 0
    cdef Py_ssize_t N = len(input)
    cdef double val
    cdef double prev
    cdef ndarray[double_t] output = np.empty(N, dtype=float)
    
    for i from 0 <= i < minp - 1:
        val = input[i]
        
        # Not NaN
        if val == val:
            nobs += 1
            
            if val > threshold:
                larger += 1
            elif val < threshold:
                smaller += 1
            else:
                equal += 1
                
        output[i] = NaN
                    
    for i from minp - 1 <= i < N:
        val = input[i]
        
        if i > win - 1:
            prev = input[i - win]
            
            if prev == prev:
                nobs -= 1
                if prev > threshold:
                    larger -= 1
                elif prev < threshold:
                    smaller -= 1
                else:
                    equal -= 1
                    
        if val == val:
            nobs += 1
            if val > threshold:
                larger += 1
            elif val < threshold:
                smaller += 1
            else:
                equal += 1
                
        if nobs >= minp:
            output[i] = (smaller + (equal / 2))
            
    return output
    
                             
                     
                     
                     
        
                
                
            
    
    
    