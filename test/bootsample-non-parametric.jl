module TestBootsampleNonParametric

using Bootstrap
using Bootstrap.Datasets
using FactCheck

using DataFrames
using StatsBase

function test_bootsample(bs, ref, raw_data, n)

    show(IOBuffer(), bs)
    @fact issubtype(typeof(bs), NonParametricBootstrapSample) --> true
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
    
    @fact_throws MethodError model(bs)
    
    return Void
end

function test_ci(bs)
    
    cim_all = (BasicConfInt(), PercentileConfInt(), NormalConfInt(), BCaConfInt())
    for cim in cim_all
        c = ci(bs, cim)
        [@fact (x[1] >= x[2]  && x[1] <= x[3]) --> true for x in c]
        [@fact x[1] --> roughly(t0) for (x, t0) in zip(c, original(bs))]
        @fact level(cim) --> 0.95
    end

    return Void
end

n = 250

## 'city' dataset
citya = convert(DataArray, city)

city_ratio(df::DataFrames.DataFrame) = mean(df[:,:X]) ./ mean(df[:,:U])
city_ratio(a::AbstractArray) = mean(a[:,2]) ./ mean(a[:,1])

city_cor(x::AbstractArray) = cor(x[:,1], x[:,2])
city_cor(x::AbstractDataFrame) = cor(x[:,:X], x[:,:U])

facts("Basic resampling") do
    
    context("city_ratio with DataFrame input") do
        ref = city_ratio(city)
        @fact ref --> roughly(1.5203125)
        bs = bootstrap(city, city_ratio, BasicSampling(n))
        test_bootsample(bs, ref, city, n)
        test_ci(bs)
    end

    context("city_cor with DataFrame input") do
        ref = city_cor(city)
        bs = bootstrap(city, city_cor, BasicSampling(n))
        test_bootsample(bs, ref, city, n)
        test_ci(bs)
    end

    context("city_cor with DataArray input") do
        ref = city_cor(citya)
        bs = bootstrap(citya, city_cor, BasicSampling(n))
        test_bootsample(bs, ref, citya, n)
        test_ci(bs)
    end

    context("mean_and_sd: Vector input, 2 output variables") do
        r = randn(25)
        ref = mean_and_std(r)
        bs = bootstrap(r, mean_and_std, BasicSampling(n))
        test_bootsample(bs, ref, r, n)
        test_ci(bs)
    end

    context("mean_and_sd: Student CI") do
        r = randn(25)
        bs = bootstrap(r, mean_and_std, BasicSampling(n))
        ## Student confint
        cim = StudentConfInt()
        c = ci(bs, straps(bs, 2), cim, 1)
        @fact (c[1] >= c[2]  && c[1] <= c[3]) --> true
        @fact c[1] --> roughly(original(bs, 1))
        @fact level(cim) --> 0.95
    end

end

facts("Antithetic resampling") do

    context("mean_and_sd: Vector input, 2 output variables") do
        r = randn(50)
        ref = mean_and_std(r)
        bs = bootstrap(r, mean_and_std, AntitheticSampling(n))
        test_bootsample(bs, ref, r, n)
        test_ci(bs)
    end

end
    
facts("Balanced resampling") do
    
    context("city_ratio with DataFrame input") do
        ref = city_ratio(city)
        @fact ref --> roughly(1.5203125)
        bs = bootstrap(city, city_ratio, BalancedSampling(n))
        test_bootsample(bs, ref, city, n)
        test_ci(bs)
    end

    context("city_cor with DataFrame input") do
        ref = city_cor(city)
        bs = bootstrap(city, city_cor, BalancedSampling(n))
        test_bootsample(bs, ref, city, n)
        test_ci(bs)
    end

    context("city_cor with DataArray input") do
        ref = city_cor(citya)
        bs = bootstrap(citya, city_cor, BalancedSampling(n))
        test_bootsample(bs, ref, citya, n)
        test_ci(bs)
    end

    context("mean_and_sd: Vector input, 2 output variables") do
        r = randn(50)
        ref = mean_and_std(r)
        bs = bootstrap(r, mean_and_std, BalancedSampling(n))
        test_bootsample(bs, ref, r, n)
        test_ci(bs)
        ## mean should be unbiased
        @fact bias(bs)[1] --> roughly(0.0, 1e-8)
    end

end
    
facts("Exact resampling") do

    nc = Bootstrap.nrun_exact(nrow(city))

    context("city_ratio with DataFrame input") do
        ref = city_ratio(city)
        @fact ref --> roughly(1.5203125)
        bs = bootstrap(city, city_ratio, ExactSampling())
        test_bootsample(bs, ref, city, nc)
        test_ci(bs)
    end

    context("mean: Vector input, 1 output variables") do
        r = randn(10)
        ref = mean(r)
        bs = bootstrap(r, mean, ExactSampling())
        test_bootsample(bs, ref, r, nc)
        test_ci(bs)
    end

end

end
