"""
Type `BootstrapSample` that stores the result of a bootstrap sampling.  An object of this class is returned by the `boot` functions.
"""
type BootstrapSample{E,S,D}
    t0::E
    t1::S
    fun::Function
    x::D
    m::Integer
    @compat wv::Union{WeightVec, Integer} ## Nullable() ?
    method::Symbol
end


"""
Estimate the bias of a bootstrap sampling.
"""
function bias(bs::BootstrapSample)
    b = mean(bs.t1) - bs.t0
    return b
end


"""
Estimate the standard error of a bootstrap sampling.
"""
function se(bs::BootstrapSample)
    v = std(bs.t1)
    return v
end


"""
Return the raw estimate `t0`, calculated by `fun(data)`, from a bootstrap sampling.
"""
function estimate(bs::BootstrapSample)
    return bs.t0
end


"""
Return the bootstrapped estimates `t1`from a bootstrap sampling.
"""
function straps(bs::BootstrapSample)
    return bs.t1
end


"""
Return the original data from a bootstrap sampling.
"""
function data(bs::BootstrapSample)
    return bs.x
end


"""
Return the sampling method as a symbol from a bootstrap sampling.
"""
function method(bs::BootstrapSample)
    return bs.method
end


"""
Class `BootstrapCI` that stores the result of a bootstrap-based confidence interval.  An object of this class is returned by the `ci` functions.
"""
type BootstrapCI{E}
    t0::E
    lower::AbstractFloat
    upper::AbstractFloat
    level::AbstractFloat
    method::Symbol
end


"""
Return the raw estimate `t0`, calculated by `fun(data)`, from a bootstrap confidence interval.
"""
function estimate(bs::BootstrapCI)
    return bs.t0
end


"""
Return the lower and upper bound of the confidence interval.
"""
function interval(bs::BootstrapCI)
    return [bs.lower, bs.upper]
end


"""
Return the width of a bootstrap confidence interval, given by the difference of the upper and lower bound.
"""
function width(x::BootstrapCI)
    return x.upper - x.lower
end


"""
Return the confidence level [0, 1] of a bootstrap confidence interval.
"""
function level(bs::BootstrapCI)
    return bs.level
end


"""
Return the confidence interval method as a symbol from a bootstrap confidence interval.
"""
function method(bs::BootstrapCI)
    return bs.method
end
