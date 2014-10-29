type BootstrapSample
    t0
    t1
    fun::Function
    x
    m::Integer
    wv
    method::Symbol
end

function bias(bs::BootstrapSample)
    b = mean(bs.t1) - bs.t0
    return b
end

function se(bs::BootstrapSample)
    v = std(bs.t1)
    return v
end

function estimate(bs::BootstrapSample)
    return bs.t0
end

function straps(bs::BootstrapSample)
    return bs.t1
end

function data(bs::BootstrapSample)
    return bs.x
end

function method(bs::BootstrapSample)
    return bs.method
end

type BootstrapCI
    t0
    lower
    upper
    level::FloatingPoint
    method::Symbol
end

function estimate(bs::BootstrapCI)
    return bs.t0
end

function interval(bs::BootstrapCI)
    return [bs.lower, bs.upper]
end

function level(bs::BootstrapCI)
    return bs.level
end

function method(bs::BootstrapCI)
    return bs.method
end
