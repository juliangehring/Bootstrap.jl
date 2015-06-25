module Bootstrap

"""
Statistical bootstrapping library in julia.

The typical steps of an analysis include generating a bootstrap sampling with
the `boot_*` and calculating a confidence interval with the `ci_*` functions.
"""
Bootstrap

using StatsBase
using Iterators
using Distributions
using DataFrames

import StatsBase: sample
import Distributions: estimate
import DataArrays: data

## documentation
using Lexicon

export
    ## types
    BootstrapSample,
    BootstrapCI,
    ## methods
    boot,
    boot_basic,
    boot_weight,
    boot_balanced,
    boot_exact,
    estimate,
    straps,
    data,
    method,
    level,
    interval,
    width,
    bias,
    se,
    ci,
    ci_basic,
    ci_perc,
    ci_normal,
    ci_bca,
    ci_student

include("types.jl")
include("utils.jl")
include("sample.jl")
include("boot.jl")
include("ci.jl")
include("show.jl")

end # module
