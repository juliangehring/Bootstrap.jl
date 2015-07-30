const _show_pad = 12
const _show_signif = 5

function Base.show(io::IO, x::BootstrapSample)
    r = _show_pad
    s = _show_signif
    println(io, "Bootstrap Sampling")
    println(io, rpad("  Estimate:", r), signif(x.t0, s))
    println(io, rpad("  Bias:", r), signif(bias(x), s))
    println(io, rpad("  StdError:", r), signif(se(x), s))
    println(io, rpad("  Samples:", r), x.m)
    println(io, rpad("  Method:", r), x.method)
    println(io, rpad("  Data:", r), data_summary(x.x))
end

function Base.show(io::IO, x::BootstrapCI)
    r = _show_pad
    s = _show_signif
    println(io, "Bootstrap Confidence Interval")
    println(io, rpad("  Estimate:", r), signif(x.t0, s))
    println(io, rpad("  Interval:", r), interval(x))
    println(io, rpad("  Level:", r), x.level)
    println(io, rpad("  Method:", r), x.method)
end


"""
Summarizes an object in the form of 'TYPE: { SIZE }'
"""
function data_summary(x)
    t = string(typeof(x))
    n = length(size(x)) > 0 ? size(x) : length(x)
    ns = join(n, " \u00D7 ") # Unicode 'times'
    s = "$t: { $ns }"
    return s
end
