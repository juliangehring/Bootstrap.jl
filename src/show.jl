function Base.show(io::IO, x::BootstrapSample)
    r = 12
    println("BootstrapSample")
    println(rpad("  Method:", r), x.method)
    println(rpad("  Samples:", r), x.m)
    println(rpad("  t0:", r), x.t0)
    println(rpad("  t1:", r), x.t1)
    println(rpad("  Data:", r), x.x)
end
