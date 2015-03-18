module Bootstrap

using StatsBase
using Iterators
using Distributions
using DataFrames

import StatsBase: sample
import Distributions: estimate
import DataArrays: data

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
    ci_bca

## documentation
VERSION < v"0.4-" && using Docile

include("classes.jl")
include("utils.jl")
include("sample.jl")
include("boot.jl")
include("ci.jl")
include("show.jl")

end # module
