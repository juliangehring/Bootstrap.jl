abstract ConfIntMethod

const _level = 0.95

type BasicConfInt <: ConfIntMethod
    level::AbstractFloat
end

BasicConfInt() = BasicConfInt(_level)

type PercentileConfInt <: ConfIntMethod
    level::AbstractFloat
end

PercentileConfInt() = PercentileConfInt(_level)

type NormalConfInt <: ConfIntMethod
    level::AbstractFloat
end

NormalConfInt() = NormalConfInt(_level)

type BCaConfInt <: ConfIntMethod
    level::AbstractFloat
    ## quantile method
end

BCaConfInt() = BCaConfInt(_level)

level(cim::ConfIntMethod) = cim.level


function ci(bs::BootstrapSample, cim::ConfIntMethod)
    tuple([ci(bs, cim, i) for i in 1:nvar(bs)]...)
end


## basic
function ci(bs::BootstrapSample, cim::BasicConfInt, i::Int)
    l = level(cim)
    t0 = original(bs)[i]
    t1 = straps(bs)[i]
    alpha = ([l, -l] + 1)/2
    lower, upper = 2 * t0 - quantile(t1, alpha)
    return t0, lower, upper
end

## percentile
function ci(bs::BootstrapSample, cim::PercentileConfInt, i::Int)
    l = level(cim)
    t0 = original(bs)[i]
    t1 = straps(bs)[i]
    alpha = ([-l, l] + 1)/2
    lower, upper = quantile(t1, alpha)
    return t0, lower, upper
end

## normal
function ci(bs::BootstrapSample, cim::NormalConfInt, i::Int)
    l = level(cim)
    t0 = original(bs)[i]
    t0b = t0 - bias(bs)[i]
    merr = se(bs)[i] * quantile(Normal(), (1+l)/2)
    lower = t0b - merr
    upper = t0b + merr
    return t0, lower, upper
end

## BCa
function ci(bs::BootstrapSample, cim::BCaConfInt, i::Int)
    l = level(cim)
    t0 = original(bs)[i]
    t1 = straps(bs)[i]
    n = length(t1)
    alpha = ([-l, l] + 1)/2
    z0 = quantile(Normal(), mean(t1 .< t0))
    jkt = jack_knife_estimate(data(bs), statistic(bs))
    resid = (n-1) .* (t0 - jkt)
    a = sum(resid.^3) / (6.*(sum(resid.^2)).^(1.5))
    qn = quantile(Normal(), alpha)
    z1 = z0 + qn
    zalpha = cdf(Normal(), z0 + (z1) ./ (1-a*(z1)))
    lower, upper = quantile(t1, zalpha)
    return t0, lower, upper
end
