# Bootstrap.jl News and Changes

## Version 2.4.0

### Changes

- Extend compatibility for `Statistics`, `StatsBase`, `StatsModels` and `Random`.
- Clarify return value of `confint`. Contributed by Hector Perez (@hdavid16) (#95).
- Update doc strings. Contributed by Hector Perez (@hdavid16) (#95).
- Update documentation.


## Version 2.3.3

### Changes

- Extend supported versions of `Distributions` to v0.25.


## Version 2.3.2

### Changes

- Extend supported versions of `DataFrames` to v1.0. Contributed by Bogumił Kamiński (@bkamins) (#83).
- Update DOI badge.


## Version 2.3.1

### Changes

- Improve documentation deployment.


## Version 2.3.0

### Changes

- Performance improvements through parameterized types. Contributed by David Widmann (@devmotion) (#66).
- Specialized Jack-Knife estimator. Contributed by David Widmann (@devmotion) (#67).
- Switch to Github Actions for testing and documentation generation (#75).
- Update links to external webpages in the documentation (#75).
- Extend support to `Distributions` v0.24 (#76).


## Version 2.2.1

### Changes

- Use upper bounds for dependencies. Contributed by Milan Bouchet-Valat (@nalimilan) (#74).


## Version 2.2.0

### Changes

- Support StatsModels v0.6 with `FormulaTerm`. Contributed by Dave Kleinschmidt (@kleinschmidt) (#57).
- Use `RDatasets` instead of internal data sets. Contributed by David Widmann (@devmotion) (#60).
- Fix deprecations in `DataFrames` and `GLM` (#62).
- Increase compatibility with package management in newer julia versions (#61).


## Version 2.1.0

### Changes

- Update continuous integration configuration (#39)
- Widen the signature for `draw!`:  No longer restrict source and destination `AbstractVectors` to be of the same type, and switch to the more general `AbstractMatrix` type. Contributed by Dave Kleinschmidt (@kleinschmidt) (#43).
- Improve error handling of `BCaConfInt` if all the input data has the same value. Contributed by Rory Finnegan (@rofinn) (#40).
- Add Project.toml and Manifest.toml. Contributed by Colin Bowers (@colintbowers) (#48).
- Restrict compatible versions of the `StatsModels` dependency. Contributed by Mike Molignano (@mmolignano) (#53).


## Version 2.0.1

### Changes

- Fix `Documenter` version to v0.19 for building the documentation (#35)
- Fix `convert` deprecation in `DataFrames`, bump required version to v0.16.0


## Version 2.0.0

### Interface changes

- Put the function argument first in the signatures (#26): Changes the bootstrap signature to have the function argument come first: `bootstrap(statistic::Function, data, sampling)`. The old syntax has been deprecated and will be removed in a future version.
- Integrate better with StatsBase function names (#24): Integrates with the naming of the equivalent functions in StatsBase.jl: Renames ci to confint and se to stderror. The old function names have been deprecated, and will be supported until the next major release. The motivation for these change is outlined in #23.

### Changes

- Build the html documentation directly with Documenter (#28, #25)
- Support julia v0.7 and v1.0, drop support for julia v0.6 (#33)

### Support

- Requires julia 0.7 or v1.0


## Version 1.2.0

### New features

- Maximum Entropy bootstrapping for dependent and non-stationary datasets
  (`MaximumEntropySampling`), contributed by Rory Finnegan (@rofinn).

### Changes

- Transition tests from `FactCheck` to `Base.Test`.
- Introduces `StatsModels` as a new dependency which is now the new home of `Formula`s.
- Use vectorized function calls for `Distribution` functions.
- Removes the dependency on `Compat`.


### Support

- Requires julia 0.6 or newer
- Drops support for julia 0.5


## Version 1.1.0

### Changes

- Adds compatibility with julia 0.6 development versions, inc- Supports formula macros for DataFrame formulas (required for using [`DataFrames`](https://github.com/JuliaData/DataFrames.jl/pull/1170) v0.9.0 or newer)
- Fixes convergence errors of GLM models in parametric bootstrap test cases
- Modernise automated test and coverage setup (also thanks to [Tony Kelman](https://github.com/tkelman) for contributions)
- Improves the readme (also thanks to [Patrick Kofod Mogensen](https://github.com/pkofod) for contributions)
luding automated tests.
- Introduces `Compat` as a new dependency
- Supports formula macros for DataFrame formulas (required for using [`DataFrames`](https://github.com/JuliaData/DataFrames.jl/pull/1170) v0.9.0 or newer)
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
