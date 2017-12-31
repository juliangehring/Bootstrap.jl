# Bootstrap.jl News and Changes


## Unreleased

### Changes

- Introduces `StatsModels` as a new dependency: This is now the new home of `Formula`s.
- Removes the dependency on `Compat`.


### Support

- Requires julia 0.6 or newer
- Drops support for julia 0.5


## Version 1.1.0

### Changes

- Adds compatibility with julia 0.6 development versions, inc- Supports formula macros for DataFrame formulas (required for using [`DataFrames`](https://github.com/JuliaStats/DataFrames.jl/pull/1170) v0.9.0 or newer)
- Fixes convergence errors of GLM models in parametric bootstrap test cases
- Modernise automated test and coverage setup (also thanks to [Tony Kelman](https://github.com/tkelman) for contributions)
- Improves the readme (also thanks to [Patrick Kofod Mogensen](https://github.com/pkofod) for contributions)
luding automated tests.
- Introduces `Compat` as a new dependency
- Supports formula macros for DataFrame formulas (required for using [`DataFrames`](https://github.com/JuliaStats/DataFrames.jl/pull/1170) v0.9.0 or newer)
- Fixes convergence errors of GLM models in parametric bootstrap test cases
- Modernise automated test and coverage setup (also thanks to [Tony Kelman](https://github.com/tkelman) for contributions)
- Improves the readme (also thanks to [Patrick Kofod Mogensen](https://github.com/pkofod) for contributions)


### Support

- Requires julia 0.5 or 0.6
- Drops support for julia 0.4


## Version 1.0.0


## Version 0.3.3

* Type compatibility with julia 0.4

* Test code in readme as part of the unit tests

* Script to rebuild notebook automatically

* Unified number of observations `nobs` interface with tests

* Calculate number of exact bootstrap samples explictly

* Doc notebooks: Cleanup


## Version 0.3.2

* Official support for julia 0.4

* Precompilation in julia 0.4

* DOI for release versions, making it possible to properly cite the software

* Improved `show` method for `BootstrapSample` and `BootstrapCI`


## Version 0.3.1

* Sample quantiles with Gaussian interpolation

* Generalize integer types

* Windows integration and build service

* Codecov


## Version 0.3.0

* Improved and more consistent documentation, using simple docstrings

* Data summary in show methods, instead of displaying the entire data set

* Reference list as part of the documentation


## Version 0.2.0

* Documentation of the package and the functions on readthedocs.org

* Require julia v0.3, excluding prereleases


## Version 0.1.1


## Version 0.1.0

Major changes:

* Simplify travis

* Readme: Package status and logo

* Interface: Individual functions for `boot` and `ci`

* Support `Array` and `DataFrame` input

* Require: `DataFrames` and `Docile`

* Doc: Workflows in notebooks

* Doc: Function documentation with Docile

* Extend balanced bootstrap functionality

* BCa CI with jackknife

* Parametric `Bootstrap*` types

* Generalized sampling methods

* IO in `show` methods

* Test: Doctest based on `Docile`

* Test for new functionality


## Version 0.0.3

* Test cases for `Distributions` dependencies

* Modular tests

* Remove unused plotting dependencies


## Version 0.0.2

* Normal CI in `boot_ci`, with test cases


## Version 0.0.1

Initial release
