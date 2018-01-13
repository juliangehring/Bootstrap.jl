## draw: unify rand, sample

draw!{T<:Distribution}(x::T, o) = rand!(x, o)

draw!{T<:AbstractVector}(x::T, o::T) = sample!(x, o)

function draw!{T<:AbstractArray}(x::T, o::T)
    idx = sample(1:nobs(x), nobs(o))
    for (to, from) in enumerate(idx)
        o[to,:] = x[from,:]
    end
    return o
end

function draw!{T<:AbstractDataFrame}(x::T, o::T)
    idx = sample(1:nobs(x), nobs(o))
    for column in names(x)
        o[:,column] = x[idx,column]
    end
    return o
end

pick(x::AbstractVector, i::AbstractVector) = x[i]

pick(x::AbstractArray, i::AbstractVector) = slicedim(x, 1, i)

pick(x::AbstractDataFrame, i::AbstractVector) = x[i,:]

"""
    MaximumEntropyCache{T<:Real}

A cache type for storing precomputed values for a particular input array.
This is intended to minimize memory allocations and time when drawing random samples.

# Fields
- `n::Int`: Number of elements in the input array.
- `t::Type{T}`: `eltype` of the input elements.
- `inds::Vector{Int}`: Indicies of the sorted data.
- `values::Vector{T}`: Sorted values of the input data.
- `Z::Vector{T}`: Intermediate points for the ordered values.
- `mtrm::T`: Trimmed mean of deviations.
- `m::Vector{T}`: Mean of the maximum entropy density within each interval.
- `U::Vector{T}`: Preallocated array for the random noise values.
- `quantiles::Vector{T}`: Preallocated array for sample quantiles.
- `v::Vector{T}`
"""
type MaximumEntropyCache{T<:Real}
    n::Int
    t::Type{T}
    inds::Vector{Int}
    vals::Vector{T}
    Z::Vector{T}
    mtrm::T
    m::Vector{T}
    U::Vector{T}
    quantiles::Vector{T}
    v::Vector{T}
end

function MaximumEntropyCache()
    MaximumEntropyCache{Float64}(
        0,
        Float64,
        Int[],
        Float64[],
        Float64[],
        0.0,
        Float64[],
        Float64[],
        Float64[],
        Float64[],
    )
end

function init!(cache::MaximumEntropyCache, x::AbstractArray)
    cache.n = length(x)
    cache.t = eltype(x)
    sorted!(cache, x)
    trimmed!(cache, x)
    intermediates!(cache)
    med!(cache)
    cache.U = zeros(cache.t, cache.n)
    cache.quantiles = zeros(cache.t, cache.n)
    cache.v = [y / cache.n for y in 0:cache.n]
    return nothing
end

"""
    sorted!(c::MaximumEntropyCache, x::AbstractArray)

Sets the sorted indices and values for `x`.
"""
function sorted!(c::MaximumEntropyCache, x::AbstractArray)
    c.inds = sortperm(x)
    c.vals = x[c.inds]
end

"""
    trimmed!(c::MaximumEntropyCache, x::AbstractArray)

Compute our trimmed mean of deviations.
"""
function trimmed!(c::MaximumEntropyCache, x::AbstractArray)
    c.mtrm = mean([abs(x[i] - x[i - 1]) for i in 2:c.n])
end

"""
    intermediates!(c::MaximumEntropyCache)

Compute our intermediate points for the ordered values.
"""
function intermediates!(c::MaximumEntropyCache)
    c.Z = zeros(c.t, c.n + 1)
    for i in 2:c.n
        c.Z[i] = (c.vals[i-1] + c.vals[i]) /  2
    end

    # Insert our lower and upper tails using our trimmed mean
    c.Z[1] = (c.vals[1] - c.mtrm)
    c.Z[end] = (c.vals[end] + c.mtrm)
end

"""
    med!(c::MaximumEntropyCache)

Compute the mean of the maximum entropy density within each interval such that
the ‘mean-preserving constraint’ is satisfied.
"""
function med!(c::MaximumEntropyCache)
    c.m = zeros(c.t, c.n)
    c.m[1] = 0.75 * c.vals[1] + 0.25 * c.vals[1]

    for k in 2:(c.n-1)
        c.m[k] = 0.25 * c.vals[k-1] + 0.5 * c.vals[k] + 0.25 * c.vals[k+1]
    end

    c.m[end] = 0.25 * c.vals[end-1] + 0.75 * c.vals[end]
end

function draw!(cache::MaximumEntropyCache, x::T, o::T) where T<:AbstractArray
    # Generate random numbers from the [0, 1] uniform interval.
    sort!(rand!(cache.U))

    # Compute sample quantiles of the ME density at those points and sort them.
    for k in 1:cache.n
        ind = indmin(abs.(cache.v - cache.U[k]))

        if cache.v[ind] > cache.U[k]
            ind -= 1
        end

        c = (2 * cache.m[ind] - cache.Z[ind] - cache.Z[ind + 1]) / 2
        y0 = cache.Z[ind] + c
        y1 = cache.Z[ind + 1] + c
        cache.quantiles[k] =
            y0 + (cache.U[k] - cache.v[ind]) * (y1 - y0) / (cache.v[ind + 1] - cache.v[ind])
    end

    # Reorder the sorted sample quantiles by using the ordering index.
    # This recovers the time dependence relationships of the originally observed data.
    recovered = sortperm(cache.inds)
    for i in 1:cache.n
        idx = recovered[i]
        o[i] = cache.quantiles[idx]
    end

    return o
end
