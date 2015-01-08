function Base.show(io::IO, x::BootstrapSample)
    r = 12
    println(io, "Bootstrap Sampling")
    println(io, rpad("  Method:", r), x.method)
    println(io, rpad("  Samples:", r), x.m)
    println(io, rpad("  t0:", r), x.t0)
    println(io, rpad("  t1:", r), x.t1)
    println(io, rpad("  Data:", r), x.x)
end

function Base.show(io::IO, x::BootstrapCI)
    r = 12
    println(io, "Bootstrap Confidence Interval")
    println(io, rpad("  Method:", r), x.method)
    println(io, rpad("  Level:", r), x.level)
    println(io, rpad("  t0:", r), x.t0)
    println(io, rpad("  Interval:", r), interval(x))
end
