module TestBootsampleParametric

using Bootstrap
using Bootstrap.Datasets
using FactCheck

using DataFrames
using StatsBase
using GLM

function test_bootsample(bs, ref, raw_data, n)

    show(IOBuffer(), bs)
    @fact issubtype(typeof(bs), ParametricBootstrapSample) --> true
    t0 = original(bs)
    @fact length(t0) --> length(ref)
    [@fact t --> roughly(r) for (t, r) in zip(t0, ref)]
    
    t1 = straps(bs)
    @fact length(t1) --> length(t0)
    [@fact length(t) --> n for t in t1]
    [@fact (minimum(t) <= tr && maximum(t) >= tr) --> true for (t, tr) in zip(t1, t0)]
    [@fact eltype(t) --> eltype(tr) for (t, tr) in zip(t1, t0)]

    @fact Bootstrap.data(bs) --> raw_data ## TODO: define scope

    @fact nrun(sampling(bs)) --> n
    @fact nrun(bs) --> n

    @fact length(bias(bs)) --> length(ref)
    [@fact (b[1] > -Inf && b[1] < Inf) --> true for b in bias(bs)]
    @fact length(se(bs)) --> length(ref)
    [@fact s --> greater_than(0) for s in se(bs)]

    [@fact original(bs, i) --> original(bs)[i]  for i in 1:nvar(bs)]
    [@fact straps(bs, i) --> straps(bs)[i]  for i in 1:nvar(bs)]
    [@fact bias(bs, i) --> bias(bs)[i]  for i in 1:nvar(bs)]
    [@fact se(bs, i) --> se(bs)[i]  for i in 1:nvar(bs)]
    
    m = model(bs)
    @fact issubtype(typeof(m), Bootstrap.Model) --> true

    return Void
end

function test_ci(bs)
    
    cim_all = (BasicConfInt(), PercentileConfInt(), NormalConfInt(), BCaConfInt())
    for cim in cim_all
        c = ci(bs, cim)
        [@fact (x[1] >= x[2]  && x[1] <= x[3]) --> true for x in c]
        [@fact x[1] --> roughly(t0) for (x, t0) in zip(c, original(bs))]
    end

    return Void
end

n = 100

## log cannot be specified in formula, see GLM issues
city2 = DataFrame(twenty = log10(city[:,:U]),
                  thirty = log10(city[:,:X]))


facts("Parametric distributions") do

    r = randn(20)
    ref = mean(r)

    context("Basic resampling: Normal distribution") do
        bs = bootstrap(r, mean, Model(Normal), BasicSampling(n))
        test_bootsample(bs, ref, r, n)
        test_ci(bs)
    end

    context("Balanced resampling: Normal distribution") do
        bs = bootstrap(r, mean, Model(Normal), BalancedSampling(n))
        test_bootsample(bs, ref, r, n)
        test_ci(bs)
    end

    ref = mean(fit(Exponential, aircondit))

    context("Basic resampling: Exponential distribution") do
        bs = bootstrap(aircondit, mean, Model(Exponential), BasicSampling(n))
        test_bootsample(bs, ref, aircondit, n)
        test_ci(bs)
    end

    context("Balanced resampling: Exponential distribution") do
        bs = bootstrap(aircondit, mean, Model(Exponential), BalancedSampling(n))
        test_bootsample(bs, ref, aircondit, n)
        test_ci(bs)
    end

end

facts("Linear regression models") do

    ref = coef(fit(LinearModel, thirty ~ twenty, city2))

    context("Residual resampling") do
        bs = bootstrap(city2, coef, Model(LinearModel, thirty ~ twenty), ResidualSampling(n))
        test_bootsample(bs, ref, city2, n)
    end

    context("Wild resampling: Rademacher") do
        bs = bootstrap(city2, coef, Model(LinearModel, thirty ~ twenty), WildSampling(n, rademacher))
        test_bootsample(bs, ref, city2, n)
        @fact typeof(noise(sampling(bs))) --> Function
    end

    context("Wild resampling: Mammen") do
        bs = bootstrap(city2, coef, Model(LinearModel, thirty ~ twenty), WildSampling(n, mammen))
        test_bootsample(bs, ref, city2, n)
        @fact typeof(noise(sampling(bs))) --> Function
    end

end

facts("Generalized linear regression models") do

    ref = coef(fit(GeneralizedLinearModel, thirty ~ twenty, city2, Normal()))

    context("Residual resampling") do
        bs = bootstrap(city2, coef, Model(GeneralizedLinearModel, thirty ~ twenty, Normal()), ResidualSampling(n))
        test_bootsample(bs, ref, city2, n)
    end

    context("Residual resampling with link function") do
        bs = bootstrap(city2, coef, Model(GeneralizedLinearModel, thirty ~ twenty, Normal(), IdentityLink()), ResidualSampling(n))
        test_bootsample(bs, ref, city2, n)
    end

    context("Wild resampling: Rademacher") do
        bs = bootstrap(city2, coef, Model(GeneralizedLinearModel, thirty ~ twenty, Normal()), WildSampling(n, rademacher))
        test_bootsample(bs, ref, city2, n)
        @fact typeof(noise(sampling(bs))) --> Function
    end

    context("Wild resampling with link function: Mammen") do
        bs = bootstrap(city2, coef, Model(GeneralizedLinearModel, thirty ~ twenty, Normal(), IdentityLink()), WildSampling(n, mammen))
        test_bootsample(bs, ref, city2, n)
        @fact typeof(noise(sampling(bs))) --> Function
    end

end

end
