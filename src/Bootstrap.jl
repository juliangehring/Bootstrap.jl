VERSION >= v"0.4.0" && __precompile__(true)

"""
# Bootstrap package

Statistical bootstrapping for Julia
"""
module Bootstrap

using StatsBase
using Distributions
using DataFrames

import Base: start, next, done, eltype, length

export
    Model,
    nvar,
    nrun,
    draw!,
    rademacher,
    mammen,
    iquantile,
    bootstrap,
    BasicSampling,
    BalancedSampling,
    ExactSampling,
    ResidualSampling,
    WildSampling,
    BootstrapSample,
    NonParametricBootstrapSample,
    ParametricBootstrapSample,
    original,
    straps,
    data,
    model,
    statistic,
    sampling,
    noise,
    bias,
    se,
    ci,
    BasicConfInt,
    PercentileConfInt,
    NormalConfInt,
    BCaConfInt,
    level

include("stats.jl")
include("nobs.jl")
include("draw.jl")
include("bootsampling.jl")
include("get.jl")
include("show.jl")
include("confint.jl")
include("datasets/Datasets.jl")

end
