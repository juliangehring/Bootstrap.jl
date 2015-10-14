# Bootstrap.jl: Statistical Bootstrapping

## Package Status

### Development Version

[![Documentation Status](https://readthedocs.org/projects/bootstrapjl/badge/?version=master)](http://bootstrapjl.readthedocs.org/en/master/)
[![Linux Build Status](https://travis-ci.org/julian-gehring/Bootstrap.jl.svg?branch=master)](https://travis-ci.org/julian-gehring/Bootstrap.jl)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/859sj436an6ikoey/branch/master?svg=true)](https://ci.appveyor.com/project/julian-gehring/bootstrap-jl/branch/master)
[![Coverage Status](http://codecov.io/github/julian-gehring/Bootstrap.jl/coverage.svg?branch=master)](http://codecov.io/github/julian-gehring/Bootstrap.jl?branch=master&view=all)


## Motivation

Bootstrapping is a widely applicable technique for statistical estimation.

![img](doc/bootstraps.png)


## References

The [bootstrapping wikipedia article](https://en.wikipedia.org/wiki/Bootstrapping_(statistics))
is a comprehensive summary of the topic.  An extensive description of the
bootstrap is the focus of the book *Davison and Hinkley (1997):
[Bootstrap Methods and Their Application](http://statwww.epfl.ch/davison/BMA/)*.
Most of the methodology covered in the book is implemented in the
[boot](http://cran.r-project.org/web/packages/boot/index.html) package for the
[R programming language](http://www.r-project.org/).
