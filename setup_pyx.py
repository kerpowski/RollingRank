# -*- coding: utf-8 -*-
"""
Created on Sat Feb 14 16:42:51 2015

@author: kerpowski
"""

from distutils.core import setup
from Cython.Build import cythonize
import numpy

sourcefiles = ['rolling_rank.pyx']

compiler_directives={'boundscheck': False,
                     'cdivision': True,
                     'language_level':3}
                     

ext_modules = cythonize(sourcefiles, compiler_directives=compiler_directives)

setup(
    name = 'Fast rolling rank',
    ext_modules = ext_modules,
    include_dirs=[numpy.get_include()]
)