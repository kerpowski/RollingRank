# -*- coding: utf-8 -*-
"""
Created on Thu Jan 14 20:37:51 2016

@author: kerpowski
"""

import pandas as pd
from rolling_rank import roll_rank
import numpy as np
from scipy import stats
import time

array_size = 100000
foo = pd.DataFrame(np.random.uniform(size=array_size))
window_size = 50
# stupid floating point arithmatic messing up the scipy version comparison
epsilon = 0.00000001 

start = time.time()
a = roll_rank(foo[0].values, window_size, window_size, 0.8)
end = time.time()
print('cython ranking: {0} seconds', end-start)

def precentile_of_score(array):
    return stats.percentileofscore(array, 0.8)

start = time.time()
# adjust from percentile to rank
adj_factor = window_size / 100
b = pd.rolling_apply(foo[0], window_size, precentile_of_score) * adj_factor
end = time.time()
print('percentileofscore ranking: {0} seconds', end-start)  

bar = pd.DataFrame(abs(a - b) < epsilon)
if np.count_nonzero(bar[0]) == array_size - window_size + 1:
    print('Correct number of equal values')
else:
    print('Incorrect number of equal values')





 