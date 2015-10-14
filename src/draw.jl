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
