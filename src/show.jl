function Base.show(io::IO, x::BootstrapSample)
    r = 12
    s = 5
    println(io, "Bootstrap Sampling")
    println(io, rpad("  Method:", r), x.method)
    println(io, rpad("  Samples:", r), x.m)
    println(io, rpad("  Estimate:", r), x.t0)
    println(io, rpad("  Bias:", r), signif(bias(x), s))
    println(io, rpad("  SE:", r), signif(se(x), s))
    println(io, rpad("  Data:", r), data_summary(x.x))
end

function Base.show(io::IO, x::BootstrapCI)
    r = 12
    println(io, "Bootstrap Confidence Interval")
    println(io, rpad("  Method:", r), x.method)
    println(io, rpad("  Level:", r), x.level)
    println(io, rpad("  t0:", r), x.t0)
    println(io, rpad("  Interval:", r), interval(x))
end

"""
Summarizes an object in the form of 'TYPE: { SIZE }'
"""
function data_summary(x)
    t = string(typeof(x))
    n = length(size(x)) > 0 ? size(x) : length(x)
    ns = join(n, " x ")
    s = "$t: { $ns }"
    return s
end
