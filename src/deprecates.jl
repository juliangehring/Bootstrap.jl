import Base.@deprecate
import Base.depwarn

# ci -> confint
@deprecate ci(bs::BootstrapSample, cim::T) where T<:ConfIntMethod confint(bs, cim)
@deprecate ci(bs::BootstrapSample, cim::T, i::Int) where T<:ConfIntMethod confint(bs, cim, i)
@deprecate ci(bs::BootstrapSample, sd::AbstractVector, cim::T, i::Int) where T<:ConfIntMethod confint(bs, sd, cim, i)

# se -> stderror
@deprecate se(x::AbstractVector) stderror(x)
@deprecate se(bs::BootstrapSample) stderror(bs)
@deprecate se(bs::BootstrapSample, idx::Int) stderror(bs, idx)
