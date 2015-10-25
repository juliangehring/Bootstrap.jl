module TestBootsampleNonParametric

using Bootstrap
using Bootstrap.Datasets
using Base.Test

using DataFrames
using StatsBase

n = 250

function test_bootsample(bs, ref, raw_data, n)

    show(IOBuffer(), bs)
    @test issubtype(typeof(bs), NonParametricBootstrapSample)
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

    [@test original(bs, i) == original(bs)[i]  for i in 1:nvar(bs)]
    [@test straps(bs, i) == straps(bs)[i]  for i in 1:nvar(bs)]
    [@test bias(bs, i) == bias(bs)[i]  for i in 1:nvar(bs)]
    [@test se(bs, i) == se(bs)[i]  for i in 1:nvar(bs)]
    
    @test_throws MethodError model(bs)
    
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

## 'city' dataset
citya = convert(DataArray, city)

city_ratio(df::DataFrames.DataFrame) = mean(df[:,:X]) ./ mean(df[:,:U])
city_ratio(a::AbstractArray) = mean(a[:,2]) ./ mean(a[:,1])

city_cor(x::AbstractArray) = cor(x[:,1], x[:,2])
city_cor(x::AbstractDataFrame) = cor(x[:,:X], x[:,:U])

### 1) Basic resampling

## A) DataFrame input
ref = city_ratio(city)
@test_approx_eq ref 1.5203125
bs = bootstrap(city, city_ratio, BasicSampling(n))
test_bootsample(bs, ref, city, n)
test_ci(bs)

## B) DataFrame input
ref = city_cor(city)
bs = bootstrap(city, city_cor, BasicSampling(n))
test_bootsample(bs, ref, city, n)
test_ci(bs)

## B2) DataArray input
bs = bootstrap(citya, city_cor, BasicSampling(n))
test_bootsample(bs, ref, citya, n)
test_ci(bs)

## C) Vector input, 2 output variables
r = randn(25)
ref = mean_and_std(r)
bs = bootstrap(r, mean_and_std, BasicSampling(n))
test_bootsample(bs, ref, r, n)
test_ci(bs)

### 2) Balanced resampling

## A) DataFrame input
ref = city_ratio(city)
@test_approx_eq ref 1.5203125
bs = bootstrap(city, city_ratio, BalancedSampling(n))
test_bootsample(bs, ref, city, n)
test_ci(bs)

## B) DataFrame input
ref = city_cor(city)
bs = bootstrap(city, city_cor, BalancedSampling(n))
test_bootsample(bs, ref, city, n)
test_ci(bs)

## B2) DataArray input
bs = bootstrap(citya, city_cor, BalancedSampling(n))
test_bootsample(bs, ref, citya, n)
test_ci(bs)

## C) Vector input, 2 output variables
r = randn(50)
ref = mean_and_std(r)
bs = bootstrap(r, mean_and_std, BalancedSampling(n))
test_bootsample(bs, ref, r, n)
test_ci(bs)
## mean should be unbiased
@test_approx_eq_eps bias(bs)[1] 0.0 1e-8

### 3) Exact resampling

nc = Bootstrap.nrun_exact(nrow(city))

## A) DataFrame input
ref = city_ratio(city)
@test_approx_eq ref 1.5203125
bs = bootstrap(city, city_ratio, ExactSampling())
test_bootsample(bs, ref, city, nc)
test_ci(bs)

## C) Vector input, 1 output variables
r = randn(10)
ref = mean(r)
bs = bootstrap(r, mean, ExactSampling())
test_bootsample(bs, ref, r, nc)
test_ci(bs)

end
