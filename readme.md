Rolling rank cython speedup
========

A simple rolling rank calculation on an ndarray.  Used to calculate the inverse of pandas rolling_quantile method

Requirements
- Python 3.3
- cython
- numpy

To cythonize the pyx files run "python setup.py build_ext --inplace".  If you have the output rolling_rank.pyd file in your source directory you should be able to include and use it as in the test.  Cython code should produce >100x speedup.

Heavily borrows from roll_quantile in Pandas algos.pyx.