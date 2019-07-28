"""
# Bootstrap package

Statistical bootstrapping for Julia
"""
module Bootstrap

using Statistics
using Random
using StatsBase
using Distributions
using DataFrames
using StatsModels

import Base: iterate, eltype, length, size
import StatsBase: confint, stderror

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
    AntitheticSampling,
    BalancedSampling,
    ExactSampling,
    MaximumEntropySampling,
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
    stderror,
    confint,
    BasicConfInt,
    PercentileConfInt,
    NormalConfInt,
    BCaConfInt,
    StudentConfInt,
    level

include("stats.jl")
include("nobs.jl")
include("draw.jl")
include("bootsampling.jl")
include("get.jl")
include("show.jl")
include("confint.jl")
include("datasets/Datasets.jl")
include("deprecates.jl")

end
