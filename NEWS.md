# News: Bootstrap

## Bootstrap v0.3.3

* Type compatibility with julia 0.4

* Test code in readme as part of the unit tests

* Script to rebuild notebook automatically

* Unified number of observations `nobs` interface with tests

* Calculate number of exact bootstrap samples explictly

* Doc notebooks: Cleanup


## Bootstrap v0.3.2

* Official support for julia 0.4

* Precompilation in julia 0.4

* DOI for release versions, making it possible to properly cite the software

* Improved `show` method for `BootstrapSample` and `BootstrapCI`


## Bootstrap v0.3.1

* Sample quantiles with Gaussian interpolation

* Generalize integer types

* Windows integration and build service

* Codecov


## Bootstrap v0.3.0

* Improved and more consistent documentation, using simple docstrings

* Data summary in show methods, instead of displaying the entire data set

* Reference list as part of the documentation


## Bootstrap v0.2.0

* Documentation of the package and the functions on readthedocs.org

* Require julia v0.3, excluding prereleases


## Bootstrap v0.1.1


## Bootstrap v0.1.0

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


## Bootstrap v0.0.3

* Test cases for `Distributions` dependencies

* Modular tests

* Remove unused plotting dependencies


## Bootstrap v0.0.2

* Normal CI in `boot_ci`, with test cases


## Bootstrap v0.0.1

Initial release
