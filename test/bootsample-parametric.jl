module TestBootsampleParametric

using Bootstrap
using Bootstrap.Datasets
using Base.Test

using DataFrames
using StatsBase
using GLM

n = 100

## log cannot be specified in formula, see GLM issues
city2 = DataFrame(twenty = log10(city[:,:U]),
                  thirty = log10(city[:,:X]))

function test_bootsample(bs, ref, raw_data, n)

    show(IOBuffer(), bs)
    @test issubtype(typeof(bs), ParametricBootstrapSample)
    t0 = original(bs)
    @test length(t0) == length(ref)
    [@test_approx_eq t r for (t, r) in zip(t0, ref)]
    
    t1 = straps(bs)
    @test length(t1) == length(t0)
    [@test length(t) == n for t in t1]
    [@test minimum(t) <= tr && maximum(t) >= tr for (t, tr) in zip(t1, t0)]
    [@test eltype(t) == eltype(tr) for (t, tr) in zip(t1, t0)]

    @test raw_data == Bootstrap.data(bs) ## TODO: define scope

    @test nrun(sampling(bs)) == n
    @test nrun(bs) == n

    @test length(bias(bs)) == length(ref)
    [@test b[1] > -Inf && b[1] < Inf for b in bias(bs)]
    @test length(se(bs)) == length(ref)
    [@test s > 0 for s in se(bs)]

    m = model(bs)
    @test issubtype(typeof(m), Bootstrap.Model)

    return Void
end

function test_ci(bs)
    
    cim_all = (BasicConfInt(), PercentileConfInt(), NormalConfInt(), BCaConfInt())
    for cim in cim_all
        c = ci(bs, cim)
        [@test x[1] >= x[2]  && x[1] <= x[3] for x in c]
        [@test_approx_eq x[1] t0 for (x, t0) in zip(c, original(bs))]
    end

    return Void
end

### 1) Parametric distribution

r = randn(20)
ref = mean(r)

## A) basic resampling
bs = bootstrap(r, mean, Model(Normal), BasicSampling(n))
test_bootsample(bs, ref, r, n)
test_ci(bs)

## B) balanced resampling
bs = bootstrap(r, mean, Model(Normal), BalancedSampling(n))
test_bootsample(bs, ref, r, n)
test_ci(bs)

ref = mean(fit(Exponential, aircondit))

bs = bootstrap(aircondit, mean, Model(Exponential), BasicSampling(n))
test_bootsample(bs, ref, aircondit, n)
test_ci(bs)

bs = bootstrap(aircondit, mean, Model(Exponential), BalancedSampling(n))
test_bootsample(bs, ref, aircondit, n)
test_ci(bs)


### 2) Residual

ref = coef(fit(LinearModel, thirty ~ twenty, city2))

bs = bootstrap(city2, coef, Model(LinearModel, thirty ~ twenty), ResidualSampling(n))
test_bootsample(bs, ref, city2, n)

### 2) Wild

ref = coef(fit(LinearModel, thirty ~ twenty, city2))

bs = bootstrap(city2, coef, Model(LinearModel, thirty ~ twenty), WildSampling(n, rademacher))
test_bootsample(bs, ref, city2, n)

bs = bootstrap(city2, coef, Model(LinearModel, thirty ~ twenty), WildSampling(n, mammen))
test_bootsample(bs, ref, city2, n)

end
