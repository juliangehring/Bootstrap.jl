import Base.@deprecate
import Base.depwarn

# ci -> confint
@deprecate ci(bs::BootstrapSample, cim::ConfIntMethod) confint(bs, cim)
@deprecate ci(bs::BootstrapSample, cim::ConfIntMethod, i::Int) confint(bs, cim, i)
@deprecate ci(bs::BootstrapSample, sd::AbstractVector, cim::ConfIntMethod, i::Int) confint(bs, sd, cim, i)

# se -> stderror
@deprecate se(x::AbstractVector) stderror(x)
@deprecate se(bs::BootstrapSample) stderror(bs)
@deprecate se(bs::BootstrapSample, idx::Int) stderror(bs, idx)

# functions before data
@deprecate bootstrap(data, statistic::Function, sampling::BootstrapSampling) bootstrap(statistic, data, sampling)
@deprecate bootstrap(data, statistic::Function, model, sampling::BootstrapSampling) bootstrap(statistic, data, model, sampling)
