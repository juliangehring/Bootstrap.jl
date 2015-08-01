# Bootstrap.jl: Statistical Bootstrapping

## Package Status

[![Documentation Status](https://readthedocs.org/projects/bootstrapjl/badge/?version=release)](http://bootstrapjl.readthedocs.org/en/release/)
[![Package Status](http://pkg.julialang.org/badges/Bootstrap_release.svg)](http://pkg.julialang.org/?pkg=Bootstrap&ver=release)
[![Linux Build Status](https://travis-ci.org/julian-gehring/Bootstrap.jl.svg?branch=release)](https://travis-ci.org/julian-gehring/Bootstrap.jl)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/859sj436an6ikoey/branch/release?svg=true)](https://ci.appveyor.com/project/julian-gehring/bootstrap-jl/branch/release)
[![Coverage Status](http://codecov.io/github/julian-gehring/Bootstrap.jl/coverage.svg?branch=release)](http://codecov.io/github/julian-gehring/Bootstrap.jl?branch=release&view=all)
[![DOI](https://zenodo.org/badge/5468/julian-gehring/Bootstrap.jl.svg)](https://zenodo.org/badge/latestdoi/5468/julian-gehring/Bootstrap.jl)


## Motivation

Bootstrapping is a widely applicable technique for statistical estimation,
especially in the absence of closed-form solutions.

![img](doc/bootstraps.png)


## Functionality

- Bootstrapping statistics with different sampling methods:
  - Random resampling with replacement (the `boot_basic` bootstrap)
  - Random weighted resampling with replacement (the `boot_weight` bootstrap)
  - Balanced random resampling, reducing the bias (the `boot_balanced` bootstrap)
  - Exact resampling, iterating through all unique samples (the `boot_exact`,
    deterministic bootstrap, suited only for small samples sizes)

- Confidence intervals:
  - Basic (the `ci_basic` method)
  - Percentile (the `ci_perc` method)
  - Normal distribution (the `ci_normal` method)
  - Studendized (the `ci_student` method)
  - Bias-corrected and accelerated (BCa) (the `ci_bca` method)


## Examples

This example illustrates the basic usage and cornerstone functions of the package.
More elaborate cases are covered in the [documentation notebooks](doc/notebooks.md).

```julia
using Bootstrap
```

Our observations `r` are sampled from a standard normal distribution.

```julia
r = randn(50);
```

Let's bootstrap the standard deviation (`std`) of our data, based on 1000
resamples and with different bootstrapping approaches.

```julia
n_boot = 1000;

## basic bootstrap
bs1 = boot_basic(r, std, n_boot);
## balanced bootstrap
bs2 = boot_balanced(r, std, n_boot);
```

We can explore the properties of the bootstrapped samples, for example estimated
bias and standard error of our statistic.

```julia
bias(bs1)
se(bs1)
```

Further, we can estimate confidence intervals for our statistic of interest,
based on the bootstrapped samples.

```julia
## 95% confidence intervals
cil = 0.95;

## basic CI
bci1 = ci_basic(bs1, cil);

## percentile CI
bci2 = ci_perc(bs1, cil);

## BCa CI
bci3 = ci_bca(bs1, cil);
```

```julia
interval(bci1)
```


## References

The [bootstrapping wikipedia article](https://en.wikipedia.org/wiki/Bootstrapping_(statistics))
is a comprehensive summary of the topic.  An extensive description of the
bootstrap is the focus of the book *Davison and Hinkley (1997):
[Bootstrap Methods and Their Application](http://statwww.epfl.ch/davison/BMA/)*.
Most of the methodology covered in the book is implemented in the
[boot](http://cran.r-project.org/web/packages/boot/index.html) package for the
[R programming language](http://www.r-project.org/).


## Future

Features and improvements that are in planning/preparation:

- Parametric bootstrap

- Parallel calculations: This will be especially benefitical if each estimation
  takes long.  For simple and fast functions, the overhead of parallelization
  can make it slower.

- Performance in general: This is an important goal, and julia is a powerful
  foundation to make bootstrapping efficient.  However, getting the best
  performance depends heavily on the estimator function and the data - hence it
  often hard to find the one-fits-it-all solution.  The current implementation
  is generally efficient, more optimizations will be added.

- More use cases
