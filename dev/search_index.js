var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#Motivation-1",
    "page": "Home",
    "title": "Motivation",
    "category": "section",
    "text": "Bootstrapping is a widely applicable technique for statistical estimation.(Image: img)"
},

{
    "location": "#References-1",
    "page": "Home",
    "title": "References",
    "category": "section",
    "text": "The bootstrapping wikipedia article is a comprehensive summary of the topic.  An extensive description of the bootstrap is the focus of the book Davison and Hinkley (1997): Bootstrap Methods and Their Application.  Most of the methodology covered in the book is implemented in the boot package for the R programming language."
},

{
    "location": "library/#",
    "page": "Library",
    "title": "Library",
    "category": "page",
    "text": ""
},

{
    "location": "library/#Library-1",
    "page": "Library",
    "title": "Library",
    "category": "section",
    "text": "CurrentModule = Bootstrap\nDocTestSetup = quote\n    using Bootstrap\nend"
},

{
    "location": "library/#Sampling-1",
    "page": "Library",
    "title": "Sampling",
    "category": "section",
    "text": ""
},

{
    "location": "library/#Bootstrap.BasicSampling",
    "page": "Library",
    "title": "Bootstrap.BasicSampling",
    "category": "type",
    "text": "Basic Sampling\n\nBasicSampling(1000)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.BalancedSampling",
    "page": "Library",
    "title": "Bootstrap.BalancedSampling",
    "category": "type",
    "text": "Balanced Sampling\n\nBalancedSampling(1000)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.ExactSampling",
    "page": "Library",
    "title": "Bootstrap.ExactSampling",
    "category": "type",
    "text": "Exact Sampling\n\nExactSampling()\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.AntitheticSampling",
    "page": "Library",
    "title": "Bootstrap.AntitheticSampling",
    "category": "type",
    "text": "Antithetic Sampling\n\nAntitheticSampling(1000)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.MaximumEntropySampling",
    "page": "Library",
    "title": "Bootstrap.MaximumEntropySampling",
    "category": "type",
    "text": "Maximum Entropy Sampling\n\nMaximumEntropySampling(100)\nmaximumEntropySampling(100, MaximumEntropyCache())\n\nNOTE: Implementation based off pymeboot as the original R package is GPL licensed.\n\n\n\n\n\n"
},

{
    "location": "library/#Non-Parametric-Sampling-1",
    "page": "Library",
    "title": "Non-Parametric Sampling",
    "category": "section",
    "text": "BasicSampling\nBalancedSampling\nExactSampling\nAntitheticSampling\nMaximumEntropySampling"
},

{
    "location": "library/#Bootstrap.ResidualSampling",
    "page": "Library",
    "title": "Bootstrap.ResidualSampling",
    "category": "type",
    "text": "Residual Sampling\n\nResidualSampling(1000)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.WildSampling",
    "page": "Library",
    "title": "Bootstrap.WildSampling",
    "category": "type",
    "text": "Wild Sampling\n\nWildSampling(1000, rademacher)\nWildSampling(1000, mammen)\n\n\n\n\n\n"
},

{
    "location": "library/#Parametric-Sampling-1",
    "page": "Library",
    "title": "Parametric Sampling",
    "category": "section",
    "text": "ResidualSampling\nWildSampling"
},

{
    "location": "library/#Bootstrap.nrun",
    "page": "Library",
    "title": "Bootstrap.nrun",
    "category": "function",
    "text": "Number of samples drawn from a bootstrap sampling\n\nbs = BasicSampling(1000)\nnrun(bs)\n\n# output\n\n1000\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.statistic",
    "page": "Library",
    "title": "Bootstrap.statistic",
    "category": "function",
    "text": "Return the statistic function of a BootstrapSample\n\nbs = bootstrap(randn(20), mean, BasicSampling(100))\nstatistic(bs)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.noise",
    "page": "Library",
    "title": "Bootstrap.noise",
    "category": "function",
    "text": "Return the noise function of a wild bootstrap sampling\n\n\n\n\n\n"
},

{
    "location": "library/#Accessors-1",
    "page": "Library",
    "title": "Accessors",
    "category": "section",
    "text": "nrun\nstatistic\nnoise"
},

{
    "location": "library/#Bootstrap.BasicConfInt",
    "page": "Library",
    "title": "Bootstrap.BasicConfInt",
    "category": "type",
    "text": "Basic Confidence Interval\n\nBasicConfInt(0.95)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.PercentileConfInt",
    "page": "Library",
    "title": "Bootstrap.PercentileConfInt",
    "category": "type",
    "text": "Percentile Confidence Interval\n\nPercentileConfInt(0.95)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.NormalConfInt",
    "page": "Library",
    "title": "Bootstrap.NormalConfInt",
    "category": "type",
    "text": "Normal Confidence Interval\n\nNormalConfInt(0.95)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.StudentConfInt",
    "page": "Library",
    "title": "Bootstrap.StudentConfInt",
    "category": "type",
    "text": "Student\'s Confidence Interval\n\nStudentConfInt(0.95)\n\n\n\n\n\n"
},

{
    "location": "library/#Bootstrap.BCaConfInt",
    "page": "Library",
    "title": "Bootstrap.BCaConfInt",
    "category": "type",
    "text": "Bias-Corrected and Accelerated (BCa) Confidence Interval\n\nBCaConfInt(0.95)\n\n\n\n\n\n"
},

{
    "location": "library/#Confidence-Intervals-1",
    "page": "Library",
    "title": "Confidence Intervals",
    "category": "section",
    "text": "BasicConfInt\nPercentileConfInt\nNormalConfInt\nStudentConfInt\nBCaConfInt"
},

{
    "location": "NEWS/#",
    "page": "Changelog",
    "title": "Changelog",
    "category": "page",
    "text": ""
},

{
    "location": "NEWS/#Bootstrap.jl-News-and-Changes-1",
    "page": "Changelog",
    "title": "Bootstrap.jl News and Changes",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Version-2.2.1-1",
    "page": "Changelog",
    "title": "Version 2.2.1",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Changes-1",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Use upper bounds for dependencies. Contributed by Milan Bouchet-Valat (@nalimilan) (#74)."
},

{
    "location": "NEWS/#Version-2.2.0-1",
    "page": "Changelog",
    "title": "Version 2.2.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Changes-2",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Support StatsModels v0.6 with FormulaTerm. Contributed by Dave Kleinschmidt (@kleinschmidt) (#57).\nUse RDatasets instead of internal data sets. Contributed by David Widmann (@devmotion) (#60).\nFix deprecations in DataFrames and GLM (#62).\nIncrease compatibility with package management in newer julia versions (#61)."
},

{
    "location": "NEWS/#Version-2.1.0-1",
    "page": "Changelog",
    "title": "Version 2.1.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Changes-3",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Update continuous integration configuration (#39)\nWiden the signature for draw!:  No longer restrict source and destination AbstractVectors to be of the same type, and switch to the more general AbstractMatrix type. Contributed by Dave Kleinschmidt (@kleinschmidt) (#43).\nImprove error handling of BCaConfInt if all the input data has the same value. Contributed by Rory Finnegan (@rofinn) (#40).\nAdd Project.toml and Manifest.toml. Contributed by Colin Bowers (@colintbowers) (#48).\nRestrict compatible versions of the StatsModels dependency. Contributed by Mike Molignano (@mmolignano) (#53)."
},

{
    "location": "NEWS/#Version-2.0.1-1",
    "page": "Changelog",
    "title": "Version 2.0.1",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Changes-4",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Fix Documenter version to v0.19 for building the documentation (#35)\nFix convert deprecation in DataFrames, bump required version to v0.16.0"
},

{
    "location": "NEWS/#Version-2.0.0-1",
    "page": "Changelog",
    "title": "Version 2.0.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Interface-changes-1",
    "page": "Changelog",
    "title": "Interface changes",
    "category": "section",
    "text": "Put the function argument first in the signatures (#26): Changes the bootstrap signature to have the function argument come first: bootstrap(statistic::Function, data, sampling). The old syntax has been deprecated and will be removed in a future version.\nIntegrate better with StatsBase function names (#24): Integrates with the naming of the equivalent functions in StatsBase.jl: Renames ci to confint and se to stderror. The old function names have been deprecated, and will be supported until the next major release. The motivation for these change is outlined in #23."
},

{
    "location": "NEWS/#Changes-5",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Build the html documentation directly with Documenter (#28, #25)\nSupport julia v0.7 and v1.0, drop support for julia v0.6 (#33)"
},

{
    "location": "NEWS/#Support-1",
    "page": "Changelog",
    "title": "Support",
    "category": "section",
    "text": "Requires julia 0.7 or v1.0"
},

{
    "location": "NEWS/#Version-1.2.0-1",
    "page": "Changelog",
    "title": "Version 1.2.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#New-features-1",
    "page": "Changelog",
    "title": "New features",
    "category": "section",
    "text": "Maximum Entropy bootstrapping for dependent and non-stationary datasets (MaximumEntropySampling), contributed by Rory Finnegan (@rofinn)."
},

{
    "location": "NEWS/#Changes-6",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Transition tests from FactCheck to Base.Test.\nIntroduces StatsModels as a new dependency which is now the new home of Formulas.\nUse vectorized function calls for Distribution functions.\nRemoves the dependency on Compat."
},

{
    "location": "NEWS/#Support-2",
    "page": "Changelog",
    "title": "Support",
    "category": "section",
    "text": "Requires julia 0.6 or newer\nDrops support for julia 0.5"
},

{
    "location": "NEWS/#Version-1.1.0-1",
    "page": "Changelog",
    "title": "Version 1.1.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Changes-7",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Adds compatibility with julia 0.6 development versions, inc- Supports formula macros for DataFrame formulas (required for using DataFrames v0.9.0 or newer)\nFixes convergence errors of GLM models in parametric bootstrap test cases\nModernise automated test and coverage setup (also thanks to Tony Kelman for contributions)\nImproves the readme (also thanks to Patrick Kofod Mogensen for contributions)luding automated tests.Introduces Compat as a new dependency\nSupports formula macros for DataFrame formulas (required for using DataFrames v0.9.0 or newer)\nFixes convergence errors of GLM models in parametric bootstrap test cases\nModernise automated test and coverage setup (also thanks to Tony Kelman for contributions)\nImproves the readme (also thanks to Patrick Kofod Mogensen for contributions)"
},

{
    "location": "NEWS/#Support-3",
    "page": "Changelog",
    "title": "Support",
    "category": "section",
    "text": "Requires julia 0.5 or 0.6\nDrops support for julia 0.4"
},

{
    "location": "NEWS/#Version-1.0.0-1",
    "page": "Changelog",
    "title": "Version 1.0.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Version-0.3.3-1",
    "page": "Changelog",
    "title": "Version 0.3.3",
    "category": "section",
    "text": "Type compatibility with julia 0.4\nTest code in readme as part of the unit tests\nScript to rebuild notebook automatically\nUnified number of observations nobs interface with tests\nCalculate number of exact bootstrap samples explictly\nDoc notebooks: Cleanup"
},

{
    "location": "NEWS/#Version-0.3.2-1",
    "page": "Changelog",
    "title": "Version 0.3.2",
    "category": "section",
    "text": "Official support for julia 0.4\nPrecompilation in julia 0.4\nDOI for release versions, making it possible to properly cite the software\nImproved show method for BootstrapSample and BootstrapCI"
},

{
    "location": "NEWS/#Version-0.3.1-1",
    "page": "Changelog",
    "title": "Version 0.3.1",
    "category": "section",
    "text": "Sample quantiles with Gaussian interpolation\nGeneralize integer types\nWindows integration and build service\nCodecov"
},

{
    "location": "NEWS/#Version-0.3.0-1",
    "page": "Changelog",
    "title": "Version 0.3.0",
    "category": "section",
    "text": "Improved and more consistent documentation, using simple docstrings\nData summary in show methods, instead of displaying the entire data set\nReference list as part of the documentation"
},

{
    "location": "NEWS/#Version-0.2.0-1",
    "page": "Changelog",
    "title": "Version 0.2.0",
    "category": "section",
    "text": "Documentation of the package and the functions on readthedocs.org\nRequire julia v0.3, excluding prereleases"
},

{
    "location": "NEWS/#Version-0.1.1-1",
    "page": "Changelog",
    "title": "Version 0.1.1",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS/#Version-0.1.0-1",
    "page": "Changelog",
    "title": "Version 0.1.0",
    "category": "section",
    "text": "Major changes:Simplify travis\nReadme: Package status and logo\nInterface: Individual functions for boot and ci\nSupport Array and DataFrame input\nRequire: DataFrames and Docile\nDoc: Workflows in notebooks\nDoc: Function documentation with Docile\nExtend balanced bootstrap functionality\nBCa CI with jackknife\nParametric Bootstrap* types\nGeneralized sampling methods\nIO in show methods\nTest: Doctest based on Docile\nTest for new functionality"
},

{
    "location": "NEWS/#Version-0.0.3-1",
    "page": "Changelog",
    "title": "Version 0.0.3",
    "category": "section",
    "text": "Test cases for Distributions dependencies\nModular tests\nRemove unused plotting dependencies"
},

{
    "location": "NEWS/#Version-0.0.2-1",
    "page": "Changelog",
    "title": "Version 0.0.2",
    "category": "section",
    "text": "Normal CI in boot_ci, with test cases"
},

{
    "location": "NEWS/#Version-0.0.1-1",
    "page": "Changelog",
    "title": "Version 0.0.1",
    "category": "section",
    "text": "Initial release"
},

{
    "location": "LICENSE/#",
    "page": "License",
    "title": "License",
    "category": "page",
    "text": "The Bootstrap.jl package is licensed under the MIT \"Expat\" License:Copyright (c) 2014-2019: Julian Gehring.Copyright (c) 2014-2016: Nikolaos Ignatiadis.Copyright (c) 2014: Jarno Leppänen.Copyright (c) 2017: Kira Huselius GyllingPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
},

]}
