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

## TODO: inherit from more specific types?
type BasicSampling <: BootstrapSampling
    nrun::Int
end

type BalancedSampling <: BootstrapSampling
    nrun::Int
end

type ResidualSampling <: BootstrapSampling
    nrun::Int
end

type WildSampling <: BootstrapSampling
    nrun::Int
    noise::Function
end

type ExactSampling <: BootstrapSampling
    nrun::Int
end

ExactSampling() = ExactSampling(0) ## TODO: good default value


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

nrun(bs::BootstrapSampling) = bs.nrun
nrun(bs::BootstrapSample) = nrun(sampling(bs))

statistic(bs::BootstrapSample) = bs.statistic

noise(bs::WildSampling) = bs.noise

nvar(t::Tuple) = length(t)
nvar(bs::BootstrapSample) = nvar(original(bs))

tx(x) = tuple(x...)

## TODO: see Unroll.jl for a more efficient version, worth it?
zeros_tuple(t, n) = tuple([zeros(typeof(x), n) for x in t]...)

lhs(f::Formula) = f.lhs

"""
Basic Bootstrap

bootstrap(data, statistic, sampling)
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
Balanced bootstrap

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

type ExactIterator
    inneritr::Base.Combinations{Array{Int64, 1}}
    n::Int64
end

exact(n::Int) = ExactIterator(combinations(collect(1:(2n-1)), n), n)

start(itr::ExactIterator) = start(itr.inneritr)

function next(itr::ExactIterator, s)
    c, s = next(itr.inneritr, s)
    v = Array(Int, itr.n)
    j = 1
    p = 1
    for k = 1:itr.n
        while !(j in c)
            j += 1
            p += 1
        end
        v[k] = p
        j += 1
    end
    return v, s
end

done(itr::ExactIterator, s) = done(itr.inneritr, s)

eltype(itr::ExactIterator) = Array{Int64, 1}

length(itr::ExactIterator) = length(itr.inneritr)

"""
Exact bootstrap

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
Parametric bootstrap

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
Residual parametric bootstrap

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
Wild parametric bootstrap

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
