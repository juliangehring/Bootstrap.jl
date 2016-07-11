# Bootstrap.jl: Statistical Bootstrapping


## Motivation

Bootstrapping is a widely applicable technique for statistical estimation.

![img](docs/src/bootstraps.png)


# Functionality

- Bootstrapping statistics with different resampling methods:
  - Random resampling with replacement (`BasicSampling`)
  - Antithetic resampling, introducing negative correlation between samples (`AntitheticSampling`)
  - Balanced random resampling, reducing bias (`BalancedSampling`)
  - Exact resampling, iterating through all unique resamples (`ExactSampling`):
    deterministic bootstrap, suited for small samples sizes
  - Resampling of residuals in generalized linear models (`ResidualSampling`, `WildSampling`)

- Confidence intervals:
  - Basic (`BasicConfInt`)
  - Percentile (`PercentileConfInt`)
  - Normal distribution (`NormalConfInt`)
  - Studendized (`StudentConfInt`)
  - Bias-corrected and accelerated (BCa) (`BCaConfInt`)


## Package Status

Reports on package builds for all platforms and test coverage are collected on
the [package status page](status.md).


## Installation

The `Bootstrap` package is part of the Julia ecosphere and the latest release
version simply be installed with

```julia
Pkg.add("Bootstrap")
```

More details on packages and how to manage them can be found in the
[package section](http://docs.julialang.org/en/stable/manual/packages/#adding-and-removing-packages)
of the Julia documentation.


# Examples

This example illustrates the basic usage and cornerstone functions of the package.
More elaborate cases are covered in the documentation notebooks.

```julia
  using Bootstrap
```

Our observations `r` are sampled from a standard normal distribution.

```julia
  r = randn(100);
```

Let's bootstrap the standard deviation (`std`) of our data, based on 1000
resamples and with different bootstrapping approaches.

```julia
  n_boot = 1000

  ## basic bootstrap
  bs1 = bootstrap(r, std, BasicSampling(n_boot))

  ## balanced bootstrap
  bs2 = bootstrap(r, std, BalancedSampling(n_boot))
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
  ## calculate 95% confidence intervals
  cil = 0.95;

  ## basic CI
  bci1 = ci(bs1, BasicConfInt(cil));

  ## percentile CI
  bci2 = ci(bs1, PercentileConfInt(cil));

  ## BCa CI
  bci3 = ci(bs1, BCaConfInt(cil));

  ## Normal CI
  bci4 = ci(bs1, NormalConfInt(cil));
```


## References

The [bootstrapping wikipedia article](https://en.wikipedia.org/wiki/Bootstrapping_(statistics))
is a comprehensive introduction into the topic.  An extensive description of the
bootstrap is the focus of the book *Davison and Hinkley (1997):
[Bootstrap Methods and Their Application](http://statwww.epfl.ch/davison/BMA/)*.
Most of the methodology covered in the book is implemented in the
[boot](http://cran.r-project.org/web/packages/boot/index.html) package for the
[R programming language](http://www.r-project.org/). [More references](doc/references.md)
are listed in the documentation for further reading.


## Frequently Asked Questions

- Does it have anything to do with twitter themes, webpage frameworks,
  compiling, ...?

  No, not really. This package focuses on an interesting area in statistics, but
  the term _bootstrapping_ is also used in different other contexts. You can check
  wikipedia for a longer list of
  [meanings asscoiated with bootstrapping](https://en.wikipedia.org/wiki/Bootstrapping_(disambiguation)).
