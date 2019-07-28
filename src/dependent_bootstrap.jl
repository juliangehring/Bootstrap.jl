
"DependentBootstrapSampling <- Abstract supertype for nesting all DependentBootstrap.jl sampling types"
abstract type DependentBootstrapSampling <: BootstrapSampling ; end

"""
Stationary Bootstrap Sampling

```julia
StationarySampling(1000, 5.0)
```

"""
struct StationarySampling <: DependentBootstrapSampling
    nrun::Int
    blocklength::Float64
end
db_type(x::StationarySampling) = DependentBootstrap.BootStationary()
db_blocklength_type(x::StationarySampling) = DependentBootstrap.BLPPW2009()

"""
Moving Block Bootstrap Sampling

```julia
MovingBlockSampling(1000, 5.0)
```

"""
struct MovingBlockSampling <: DependentBootstrapSampling
    nrun::Int
    blocklength::Float64
end
db_type(x::MovingBlockSampling) = DependentBootstrap.BootMoving()
db_blocklength_type(x::MovingBlockSampling) = DependentBootstrap.BLPPW2009()


"""
Circular Block Bootstrap Sampling

```julia
CircularBlockSampling(1000, 5.0)
```

"""
struct CircularBlockSampling <: DependentBootstrapSampling
    nrun::Int
    blocklength::Float64
end
db_type(x::CircularBlockSampling) = DependentBootstrap.BootCircular()
db_blocklength_type(x::CircularBlockSampling) = DependentBootstrap.BLPPW2009()


"""
No Overlap Block Bootstrap Sampling

```julia
NonoverlappingBlockSampling(1000, 5.0)
```

"""
struct NoOverlapBlockSampling <: DependentBootstrapSampling
    nrun::Int
    blocklength::Float64
end
db_type(x::NoOverlapBlockSampling) = DependentBootstrap.BootNoOverlap()
db_blocklength_type(x::NoOverlapBlockSampling) = DependentBootstrap.BLPPW2009()

"""
bootstrap(statistic, data, BasicSampling())
"""
function bootstrap(statistic::Function, data, sampling::T) where {T<:DependentBootstrapSampling}
    t0 = tx(statistic(data))
    m = nrun(sampling)
    t1 = zeros_tuple(t0, m)
    bootmethod = db_type(sampling)
    blocklengthmethod = db_blocklength_type(sampling)
    bi = DependentBootstrap.BootInput(data, nobs(data), sampling.blocklength, m, bootmethod,
                                      blocklengthmethod, db_dummy_func, db_dummy_func, nobs(data), median)
    for i in 1:m
        data1 = DependentBootstrap.dbootdata_one(data, bi)
        for (j, t) in enumerate(tx(statistic(data1)))
            t1[j][i] = t
        end
    end
    return NonParametricBootstrapSample(t0, t1, statistic, data, sampling)
end
db_dummy_func() = error("Logic fail in method called on subtype of DependentBootstrapSampling. This function should never be called")
