# Bootstrap.jl: Statistical Bootstrapping


## Package Status

Reports on package builds for all platforms and test coverage are collected on
the [package status page](status.md).


## Motivation

Bootstrapping is a widely applicable technique for statistical estimation.

![img](doc/bootstraps.png)


## Installation

The `Bootstrap` package is part of the Julia ecosphere and the latest release
version simply be installed with

```julia
Pkg.add("Bootstrap")
```

More details on packages and how to manage them can be found in the
[package section](http://docs.julialang.org/en/stable/manual/packages/#adding-and-removing-packages)
of the Julia documentation.


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

No, not really. This package is dealing with an interesting topic of statistics,
but the term bootstrapping is used in many different contexts. You can check
wikipedia for a longer list of
[meanings asscoiated with bootstrapping](https://en.wikipedia.org/wiki/Bootstrapping_(disambiguation).
