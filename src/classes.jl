type BootstrapSample{E,S,D}
    t0::E
    t1::S
    fun::Function
    x::D
    m::Integer
    wv::Union(WeightVec, Integer)
    method::Symbol
end

#bs = BootstrapSample(1.0, [1.0, 1.1, 1.2], mean, [1, 2, 3], 3, :basic)

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

type BootstrapCI{E}
    t0::E
    lower::FloatingPoint
    upper::FloatingPoint
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
