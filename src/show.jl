function Base.show(io::IO, x::BootstrapSample)
    r = 12
    println("Bootstrap Sampling")
    println(rpad("  Method:", r), x.method)
    println(rpad("  Samples:", r), x.m)
    println(rpad("  t0:", r), x.t0)
    println(rpad("  t1:", r), x.t1)
    println(rpad("  Data:", r), x.x)
end

function Base.show(io::IO, x::BootstrapCI)
    r = 12
    println("Bootstrap Confidence Interval")
    println(rpad("  Method:", r), x.method)
    println(rpad("  Level:", r), x.level)
    println(rpad("  t0:", r), x.t0)
    println(rpad("  Interval:", r), interval(x))
end
