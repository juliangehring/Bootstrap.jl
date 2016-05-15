abstract Model

type SimpleModel{T} <: Model
    class::T
    param::Tuple
end

Model(class, param...) = SimpleModel(class, tuple(param...))

type FormulaModel{T} <: Model
    class::T
    formula::Formula
    param::Tuple
end

Model(class, formula::Formula, param...) = FormulaModel(class, formula, tuple(param...))

abstract BootstrapSampling

abstract ParametricSampling <: BootstrapSampling
abstract NonParametricSampling <: BootstrapSampling


"""
Basic Sampling

```julia
BasicSampling(1000)
```

"""
type BasicSampling <: BootstrapSampling
    nrun::Int
end


"""
Balanced Sampling

```julia
BalancedSampling(1000)
```

"""
type BalancedSampling <: BootstrapSampling
    nrun::Int
end


"""
Residual Sampling

```julia
ResidualSampling(1000)
```

"""
type ResidualSampling <: BootstrapSampling
    nrun::Int
end


"""
Wild Sampling

```julia
WildSampling(1000, rademacher)
WildSampling(1000, mammen)
```

"""
type WildSampling <: BootstrapSampling
    nrun::Int
    noise::Function
end


"""
Exact Sampling

```julia
ExactSampling()
```

"""
type ExactSampling <: BootstrapSampling
    nrun::Int
end

ExactSampling() = ExactSampling(0)


abstract BootstrapSample

type NonParametricBootstrapSample{T} <: BootstrapSample
    t0::Tuple
    t1::Tuple
    statistic::Function
    data::T
    sampling::BootstrapSampling
end

type ParametricBootstrapSample{T,M} <: BootstrapSample
    t0::Tuple
    t1::Tuple
    statistic::Function
    data::T
    model::M
    sampling::BootstrapSampling
end


"""
Number of samples drawn from a bootstrap sampling

```julia
bs = BasicSampling(1000)
nrun(bs)

# output

1000
```

"""
nrun(bs::BootstrapSampling) = bs.nrun
nrun(bs::BootstrapSample) = nrun(sampling(bs))


"""
Return the statistic function of a `BootstrapSample`

```julia
bs = bootstrap(randn(20), mean, BasicSampling(100))
statistic(bs)
```

"""
statistic(bs::BootstrapSample) = bs.statistic

"""
Return the noise function of a wild bootstrap sampling
"""
noise(bs::WildSampling) = bs.noise

nvar(t::Tuple) = length(t)
nvar(bs::BootstrapSample) = nvar(original(bs))

tx(x) = tuple(x...)

## TODO: see Unroll.jl for a more efficient version, worth it?
zeros_tuple(t, n) = tuple([zeros(typeof(x), n) for x in t]...)

lhs(f::Formula) = f.lhs

"""
bootstrap(data, statistic, BasicSampling())
"""
function bootstrap(data, statistic::Function, sampling::BasicSampling)
    t0 = tx(statistic(data))
    m = nrun(sampling)
    t1 = zeros_tuple(t0, m)
    data1 = copy(data)
    for i in 1:m
        draw!(data, data1)
        for (j, t) in enumerate(tx(statistic(data1)))
            t1[j][i] = t
        end
    end
    return NonParametricBootstrapSample(t0, t1, statistic, data, sampling)
end


"""
bootstrap(data, statistic, sampling)
"""
function bootstrap(data, statistic::Function, sampling::BalancedSampling)
    n = nobs(data)
    m = nrun(sampling)
    t0 = tx(statistic(data))
    t1 = zeros_tuple(t0, m)
    idx = repmat([1:n;], m)
    ridx = zeros(Int, n, m)
    sample!(idx, ridx, replace = false)
    for i in 1:m
        for (j, t) in enumerate(tx(statistic(pick(data, ridx[:,i]))))
            t1[j][i] = t
        end
    end
    return NonParametricBootstrapSample(t0, t1, statistic, data, sampling)
end

type ExactIterator{T}
    a::T
    k::Int64
end

exact(n::Int) = ExactIterator(1:n, n)

start(itr::ExactIterator) = ones(Int, itr.k)

function next(itr::ExactIterator, s)
    r = itr.a[s]
    for i = itr.k:-1:1
        if s[i] < endof(itr.a)
            s[i] = nextind(itr.a, s[i])
            for j = i:itr.k-1
                s[j+1] = s[j]
            end
            return r, s
        end
    end
    return r, [0]
end

done(itr::ExactIterator, s) = length(s) > 0 && s[1] < 1

eltype(itr::ExactIterator) = typeof(itr.a)
eltype{T}(itr::ExactIterator{UnitRange{T}}) = Array{T, 1}
eltype{T}(itr::ExactIterator{Range{T}}) = Array{T, 1}

length(itr::ExactIterator) = binomial(length(itr.a) + itr.k - 1, itr.k)

"""
bootstrap(data, statistic, sampling)
"""
function bootstrap(data, statistic::Function, sampling::ExactSampling)
    n = nobs(data)
    m = nrun_exact(n)
    t0 = tx(statistic(data))
    t1 = zeros_tuple(t0, m)
    for (i, idx) in enumerate(exact(n))
        for (j, t) in enumerate(tx(statistic(pick(data, idx))))
            t1[j][i] = t
        end
    end
    sampling.nrun = m
    return NonParametricBootstrapSample(t0, t1, statistic, data, sampling)
end

"""
bootstrap(data, statistic, model, sampling)
"""
function bootstrap(data, statistic::Function, model::SimpleModel, sampling::BootstrapSampling)
    f0 = fit(model.class, data, model.param...)
    t0 = tx(statistic(data))
    m = nrun(sampling)
    t1 = zeros_tuple(t0, m)
    data1 = copy(data)
    for i in 1:m
        draw!(f0, data1)
        for (j, t) in enumerate(tx(statistic(data1)))
            t1[j][i] = t
        end
    end
    return ParametricBootstrapSample(t0, t1, statistic, data, model, sampling)
end


"""
bootstrap(data, statistic, model, formula, sampling)
"""
function bootstrap(data::AbstractDataFrame, statistic::Function, model::FormulaModel, sampling::ResidualSampling)
    class = model.class
    formula = model.formula
    param = model.param
    yy = lhs(formula)
    y0 = data[:,yy]
    f0 = fit(class, formula, data, param...)
    t0 = tx(statistic(f0))
    r0 = predict(f0) - y0
    m = nrun(sampling)
    t1 = zeros_tuple(t0, m)
    r1 = copy(r0)
    data1 = deepcopy(data)
    for i in 1:m
        sample!(r0, r1)
        data1[:,yy] = y0 + r1
        f1 = fit(class, formula, data1, param...)
        for (j, t) in enumerate(tx(statistic(f1)))
            t1[j][i] = t
        end
    end
    return ParametricBootstrapSample(t0, t1, statistic, data, model, sampling)
end


"""
bootstrap(data, statistic, model, formula, Wildsampling(nrun, noise))
"""
function bootstrap(data::AbstractDataFrame, statistic::Function, model::FormulaModel, sampling::WildSampling)
    class = model.class
    formula = model.formula
    param = model.param
    yy = lhs(formula)
    y0 = data[:,yy]
    f0 = fit(class, formula, data, param...)
    t0 = tx(statistic(f0))
    r0 = predict(f0) - y0
    m = nrun(sampling)
    t1 = zeros_tuple(t0, m)
    data1 = deepcopy(data)
    for i in 1:m
        data1[:,yy] = y0 + sampling.noise(r0)
        f1 = fit(class, formula, data1, param...)
        for (j, t) in enumerate(tx(statistic(f1)))
            t1[j][i] = t
        end
    end
    return ParametricBootstrapSample(t0, t1, statistic, data, model, sampling)
end
