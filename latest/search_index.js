var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Motivation-1",
    "page": "Home",
    "title": "Motivation",
    "category": "section",
    "text": "Bootstrapping is a widely applicable technique for statistical estimation.(Image: img)"
},

{
    "location": "index.html#References-1",
    "page": "Home",
    "title": "References",
    "category": "section",
    "text": "The bootstrapping wikipedia article is a comprehensive summary of the topic.  An extensive description of the bootstrap is the focus of the book Davison and Hinkley (1997): Bootstrap Methods and Their Application.  Most of the methodology covered in the book is implemented in the boot package for the R programming language."
},

{
    "location": "library.html#",
    "page": "Library",
    "title": "Library",
    "category": "page",
    "text": ""
},

{
    "location": "library.html#Library-1",
    "page": "Library",
    "title": "Library",
    "category": "section",
    "text": "CurrentModule = Bootstrap\nDocTestSetup = quote\n    using Bootstrap\nend"
},

{
    "location": "library.html#Sampling-1",
    "page": "Library",
    "title": "Sampling",
    "category": "section",
    "text": ""
},

{
    "location": "library.html#Bootstrap.BasicSampling",
    "page": "Library",
    "title": "Bootstrap.BasicSampling",
    "category": "type",
    "text": "Basic Sampling\n\nBasicSampling(1000)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.BalancedSampling",
    "page": "Library",
    "title": "Bootstrap.BalancedSampling",
    "category": "type",
    "text": "Balanced Sampling\n\nBalancedSampling(1000)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.ExactSampling",
    "page": "Library",
    "title": "Bootstrap.ExactSampling",
    "category": "type",
    "text": "Exact Sampling\n\nExactSampling()\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.AntitheticSampling",
    "page": "Library",
    "title": "Bootstrap.AntitheticSampling",
    "category": "type",
    "text": "Antithetic Sampling\n\nAntitheticSampling(1000)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.MaximumEntropySampling",
    "page": "Library",
    "title": "Bootstrap.MaximumEntropySampling",
    "category": "type",
    "text": "Maximum Entropy Sampling\n\nMaximumEntropySampling(100)\nmaximumEntropySampling(100, MaximumEntropyCache())\n\nNOTE: Implementation based off pymeboot as the original R package is GPL licensed.\n\n\n\n"
},

{
    "location": "library.html#Non-Parametric-Sampling-1",
    "page": "Library",
    "title": "Non-Parametric Sampling",
    "category": "section",
    "text": "BasicSampling\nBalancedSampling\nExactSampling\nAntitheticSampling\nMaximumEntropySampling"
},

{
    "location": "library.html#Bootstrap.ResidualSampling",
    "page": "Library",
    "title": "Bootstrap.ResidualSampling",
    "category": "type",
    "text": "Residual Sampling\n\nResidualSampling(1000)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.WildSampling",
    "page": "Library",
    "title": "Bootstrap.WildSampling",
    "category": "type",
    "text": "Wild Sampling\n\nWildSampling(1000, rademacher)\nWildSampling(1000, mammen)\n\n\n\n"
},

{
    "location": "library.html#Parametric-Sampling-1",
    "page": "Library",
    "title": "Parametric Sampling",
    "category": "section",
    "text": "ResidualSampling\nWildSampling"
},

{
    "location": "library.html#Bootstrap.nrun",
    "page": "Library",
    "title": "Bootstrap.nrun",
    "category": "function",
    "text": "Number of samples drawn from a bootstrap sampling\n\nbs = BasicSampling(1000)\nnrun(bs)\n\n# output\n\n1000\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.statistic",
    "page": "Library",
    "title": "Bootstrap.statistic",
    "category": "function",
    "text": "Return the statistic function of a BootstrapSample\n\nbs = bootstrap(randn(20), mean, BasicSampling(100))\nstatistic(bs)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.noise",
    "page": "Library",
    "title": "Bootstrap.noise",
    "category": "function",
    "text": "Return the noise function of a wild bootstrap sampling\n\n\n\n"
},

{
    "location": "library.html#Accessors-1",
    "page": "Library",
    "title": "Accessors",
    "category": "section",
    "text": "nrun\nstatistic\nnoise"
},

{
    "location": "library.html#Bootstrap.BasicConfInt",
    "page": "Library",
    "title": "Bootstrap.BasicConfInt",
    "category": "type",
    "text": "Basic Confidence Interval\n\nBasicConfInt(0.95)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.PercentileConfInt",
    "page": "Library",
    "title": "Bootstrap.PercentileConfInt",
    "category": "type",
    "text": "Percentile Confidence Interval\n\nPercentileConfInt(0.95)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.NormalConfInt",
    "page": "Library",
    "title": "Bootstrap.NormalConfInt",
    "category": "type",
    "text": "Normal Confidence Interval\n\nNormalConfInt(0.95)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.StudentConfInt",
    "page": "Library",
    "title": "Bootstrap.StudentConfInt",
    "category": "type",
    "text": "Student\'s Confidence Interval\n\nStudentConfInt(0.95)\n\n\n\n"
},

{
    "location": "library.html#Bootstrap.BCaConfInt",
    "page": "Library",
    "title": "Bootstrap.BCaConfInt",
    "category": "type",
    "text": "Bias-Corrected and Accelerated (BCa) Confidence Interval\n\nBCaConfInt(0.95)\n\n\n\n"
},

{
    "location": "library.html#Confidence-Intervals-1",
    "page": "Library",
    "title": "Confidence Intervals",
    "category": "section",
    "text": "BasicConfInt\nPercentileConfInt\nNormalConfInt\nStudentConfInt\nBCaConfInt"
},

{
    "location": "NEWS.html#",
    "page": "Changelog",
    "title": "Changelog",
    "category": "page",
    "text": ""
},

{
    "location": "NEWS.html#Bootstrap.jl-News-and-Changes-1",
    "page": "Changelog",
    "title": "Bootstrap.jl News and Changes",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS.html#Version-1.2.0-1",
    "page": "Changelog",
    "title": "Version 1.2.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS.html#New-features-1",
    "page": "Changelog",
    "title": "New features",
    "category": "section",
    "text": "Maximum Entropy bootstrapping for dependent and non-stationary datasets (MaximumEntropySampling), contributed by Rory Finnegan (@rofinn)."
},

{
    "location": "NEWS.html#Changes-1",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Transition tests from FactCheck to Base.Test.\nIntroduces StatsModels as a new dependency which is now the new home of Formulas.\nUse vectorized function calls for Distribution functions.\nRemoves the dependency on Compat."
},

{
    "location": "NEWS.html#Support-1",
    "page": "Changelog",
    "title": "Support",
    "category": "section",
    "text": "Requires julia 0.6 or newer\nDrops support for julia 0.5"
},

{
    "location": "NEWS.html#Version-1.1.0-1",
    "page": "Changelog",
    "title": "Version 1.1.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS.html#Changes-2",
    "page": "Changelog",
    "title": "Changes",
    "category": "section",
    "text": "Adds compatibility with julia 0.6 development versions, inc- Supports formula macros for DataFrame formulas (required for using DataFrames v0.9.0 or newer)\nFixes convergence errors of GLM models in parametric bootstrap test cases\nModernise automated test and coverage setup (also thanks to Tony Kelman for contributions)\nImproves the readme (also thanks to Patrick Kofod Mogensen for contributions)luding automated tests.Introduces Compat as a new dependency\nSupports formula macros for DataFrame formulas (required for using DataFrames v0.9.0 or newer)\nFixes convergence errors of GLM models in parametric bootstrap test cases\nModernise automated test and coverage setup (also thanks to Tony Kelman for contributions)\nImproves the readme (also thanks to Patrick Kofod Mogensen for contributions)"
},

{
    "location": "NEWS.html#Support-2",
    "page": "Changelog",
    "title": "Support",
    "category": "section",
    "text": "Requires julia 0.5 or 0.6\nDrops support for julia 0.4"
},

{
    "location": "NEWS.html#Version-1.0.0-1",
    "page": "Changelog",
    "title": "Version 1.0.0",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS.html#Version-0.3.3-1",
    "page": "Changelog",
    "title": "Version 0.3.3",
    "category": "section",
    "text": "Type compatibility with julia 0.4\nTest code in readme as part of the unit tests\nScript to rebuild notebook automatically\nUnified number of observations nobs interface with tests\nCalculate number of exact bootstrap samples explictly\nDoc notebooks: Cleanup"
},

{
    "location": "NEWS.html#Version-0.3.2-1",
    "page": "Changelog",
    "title": "Version 0.3.2",
    "category": "section",
    "text": "Official support for julia 0.4\nPrecompilation in julia 0.4\nDOI for release versions, making it possible to properly cite the software\nImproved show method for BootstrapSample and BootstrapCI"
},

{
    "location": "NEWS.html#Version-0.3.1-1",
    "page": "Changelog",
    "title": "Version 0.3.1",
    "category": "section",
    "text": "Sample quantiles with Gaussian interpolation\nGeneralize integer types\nWindows integration and build service\nCodecov"
},

{
    "location": "NEWS.html#Version-0.3.0-1",
    "page": "Changelog",
    "title": "Version 0.3.0",
    "category": "section",
    "text": "Improved and more consistent documentation, using simple docstrings\nData summary in show methods, instead of displaying the entire data set\nReference list as part of the documentation"
},

{
    "location": "NEWS.html#Version-0.2.0-1",
    "page": "Changelog",
    "title": "Version 0.2.0",
    "category": "section",
    "text": "Documentation of the package and the functions on readthedocs.org\nRequire julia v0.3, excluding prereleases"
},

{
    "location": "NEWS.html#Version-0.1.1-1",
    "page": "Changelog",
    "title": "Version 0.1.1",
    "category": "section",
    "text": ""
},

{
    "location": "NEWS.html#Version-0.1.0-1",
    "page": "Changelog",
    "title": "Version 0.1.0",
    "category": "section",
    "text": "Major changes:Simplify travis\nReadme: Package status and logo\nInterface: Individual functions for boot and ci\nSupport Array and DataFrame input\nRequire: DataFrames and Docile\nDoc: Workflows in notebooks\nDoc: Function documentation with Docile\nExtend balanced bootstrap functionality\nBCa CI with jackknife\nParametric Bootstrap* types\nGeneralized sampling methods\nIO in show methods\nTest: Doctest based on Docile\nTest for new functionality"
},

{
    "location": "NEWS.html#Version-0.0.3-1",
    "page": "Changelog",
    "title": "Version 0.0.3",
    "category": "section",
    "text": "Test cases for Distributions dependencies\nModular tests\nRemove unused plotting dependencies"
},

{
    "location": "NEWS.html#Version-0.0.2-1",
    "page": "Changelog",
    "title": "Version 0.0.2",
    "category": "section",
    "text": "Normal CI in boot_ci, with test cases"
},

{
    "location": "NEWS.html#Version-0.0.1-1",
    "page": "Changelog",
    "title": "Version 0.0.1",
    "category": "section",
    "text": "Initial release"
},

{
    "location": "LICENSE.html#",
    "page": "License",
    "title": "License",
    "category": "page",
    "text": "The Bootstrap.jl package is licensed under the MIT \"Expat\" License:Copyright (c) 2014-2018: Julian Gehring, Nikolaos Ignatiadis.Copyright (c) 2014: Jarno Leppänen.Copyright (c) 2017: Kira Huselius GyllingPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
},

]}
