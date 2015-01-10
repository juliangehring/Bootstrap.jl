module Bootstrap

using StatsBase
using Iterators
using Distributions
using DataFrames

import StatsBase: sample

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
    bias,
    se,
    ci,
    ci_basic,
    ci_perc,
    ci_normal

## documentation
using Docile
using Lexicon

include("classes.jl")
include("sample.jl")
include("boot.jl")
include("ci.jl")
include("show.jl")

end # module
