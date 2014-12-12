# Bootstrap.jl

# Package Status

Julia Release [![Bootstrap](http://pkg.julialang.org/badges/Bootstrap_release.svg)](http://pkg.julialang.org/?pkg=Bootstrap&ver=release) Julia Nightly [![Bootstrap](http://pkg.julialang.org/badges/Bootstrap_nightly.svg)](http://pkg.julialang.org/?pkg=Bootstrap&ver=nightly) [![Build Status](https://travis-ci.org/julian-gehring/Bootstrap.jl.svg?branch=master)](https://travis-ci.org/julian-gehring/Bootstrap.jl) [![Coverage Status](https://img.shields.io/coveralls/julian-gehring/Bootstrap.jl.svg)](https://coveralls.io/r/julian-gehring/Bootstrap.jl)

# Motivation

Bootstrapping is a widely applicable technique for statistical estimation,
especially in the absence of closed-form solutions.

# Functionality

-   Bootstrapping statistics with different sampling methods:
    -   Random resampling with replacement (the `basic` bootstrap)
    -   Random weighted resampling with replacement (the `weighted` bootstrap)
        [almost done]
    -   Balanced random resampling, reducing the bias (the `balanced` bootstrap)
    -   Exact resampling, iterating through all unique samples (the `exact`,
        deterministic bootstrap, suited only for small samples sizes)

-   Confidence intervals:
    -   basic
    -   percentile
    -   normal

# References

The [bootstrapping wikipdia article](https://en.wikipedia.org/wiki/Bootstrapping_(statistics)) is a comprehensive summary of the topic.  An
extensive description of the bootstrap is the focus of the book

Davison and Hinkley (1997): Bootstrap Methods and Their Application. Cambridge
University Press, <http://statwww.epfl.ch/davison/BMA/>

Most of the methodology covered in the book is implemented in the [boot](http://cran.r-project.org/web/packages/boot/index.html) package
for the [R programming language](http://www.r-project.org/).

# Examples

    using Bootstrap
    
    ## sample data, taken from a standard normal distribution
    r = randn(50);
    
    ## bootstrap the 'mean'
    ## not the most interesting case, but let's start light and simple
    
    ## basic bootstrap
    bs1 = boot(r, mean, 1000);
    
    bs1
    
    ## bias and variance of the bootstrapped estimates
    bias(bs1)
    se(bs1)
    
    ## balanced bootstrap
    bs2 = boot(r, mean, 1000, method = :balanced);
    
    bias(bs2)
    se(bs2)
    
    ## 95% confidence intervals
    ## basic CIs
    bci1 = ci(bs1, level = 0.95);
    
    interval(bci1)
    
    ## percentile CIs
    bci2 = ci(bs1, level = 0.95, method = :perc);
