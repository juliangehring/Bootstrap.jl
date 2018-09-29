module TestBootsampleParametric

using Bootstrap
using Bootstrap.Datasets
using Test

using DataFrames
using StatsBase
using GLM
using Distributions


@testset "Parametric bootstraps" begin

    function test_bootsample(bs, ref, raw_data, n)

        show(IOBuffer(), bs)
        @test typeof(bs) <: ParametricBootstrapSample
        t0 = original(bs)
        @test length(t0) == length(ref)
        [@test t ≈ r for (t, r) in zip(t0, ref)]

        t1 = straps(bs)
        @test length(t1) == length(t0)
        [@test length(t) == n for t in t1]
        [@test (minimum(t) <= tr && maximum(t) >= tr) for (t, tr) in zip(t1, t0)]
        [@test eltype(t) == eltype(tr) for (t, tr) in zip(t1, t0)]

        @test Bootstrap.data(bs) == raw_data

        @test nrun(sampling(bs)) == n
        @test nrun(bs) == n

        @test length(bias(bs)) == length(ref)
        [@test (b[1] > -Inf && b[1] < Inf) for b in bias(bs)]
        @test length(stderror(bs)) == length(ref)
        [@test s >= 0 for s in stderror(bs)]

        [@test original(bs, i) == original(bs)[i]  for i in 1:nvar(bs)]
        [@test straps(bs, i) == straps(bs)[i]  for i in 1:nvar(bs)]
        [@test bias(bs, i) == bias(bs)[i]  for i in 1:nvar(bs)]
        [@test stderror(bs, i) == stderror(bs)[i]  for i in 1:nvar(bs)]

        m = model(bs)
        @test typeof(m) <: Bootstrap.Model

        return Nothing
    end

    function test_confint(bs)

        cim_all = (BasicConfInt(), PercentileConfInt(), NormalConfInt(), BCaConfInt())
        for cim in cim_all
            c = confint(bs, cim)
            [@test (x[1] >= x[2]  && x[1] <= x[3]) for x in c]
            [@test x[1] ≈ t0 for (x, t0) in zip(c, original(bs))]
        end

        return Nothing
    end

    n = 100

    ## log cannot be specified in formula, see GLM issues
    city2 = DataFrame(twenty = log10.(city[:,:U]),
                      thirty = log10.(city[:,:X]))


    @testset "Parametric distributions" begin

        r = randn(20)
        ref = mean(r)

        @testset "Basic resampling: Normal distribution" begin
            bs = bootstrap(mean, r, Model(Normal), BasicSampling(n))
            test_bootsample(bs, ref, r, n)
            test_confint(bs)
        end

        @testset "Balanced resampling: Normal distribution" begin
            bs = bootstrap(mean, r, Model(Normal), BalancedSampling(n))
            test_bootsample(bs, ref, r, n)
            test_confint(bs)
        end

        ref = mean(fit(Exponential, aircondit))

        @testset "Basic resampling: Exponential distribution" begin
            bs = bootstrap(mean, aircondit, Model(Exponential), BasicSampling(n))
            test_bootsample(bs, ref, aircondit, n)
            test_confint(bs)
        end

        @testset "Balanced resampling: Exponential distribution" begin
            bs = bootstrap(mean, aircondit, Model(Exponential), BalancedSampling(n))
            test_bootsample(bs, ref, aircondit, n)
            test_confint(bs)
        end

    end

    @testset "Linear regression models" begin

        ref = coef(fit(LinearModel, @formula(thirty ~ twenty), city2))

        @testset "Residual resampling" begin
            bs = bootstrap(coef, city2, Model(LinearModel, @formula(thirty ~ twenty)), ResidualSampling(n))
            test_bootsample(bs, ref, city2, n)
        end

        @testset "Wild resampling: Rademacher" begin
            bs = bootstrap(coef, city2, Model(LinearModel, @formula(thirty ~ twenty)), WildSampling(n, rademacher))
            test_bootsample(bs, ref, city2, n)
            @test isa( noise(sampling(bs)), Function )
        end

        @testset "Wild resampling: Mammen" begin
            bs = bootstrap(coef, city2, Model(LinearModel, @formula(thirty ~ twenty)), WildSampling(n, mammen))
            test_bootsample(bs, ref, city2, n)
            @test isa( noise(sampling(bs)), Function )
        end

    end

    @testset "Generalized linear regression models" begin

        ref = coef(fit(GeneralizedLinearModel, @formula(thirty ~ twenty), city2, Normal()))
        max_iter = 200
        conv_tol = 1e-3

        @testset "Residual resampling" begin
            bs = bootstrap(coef, city2,
                           Model(GeneralizedLinearModel, @formula(thirty ~ twenty), Normal(), maxIter = max_iter, convTol = conv_tol),
                           ResidualSampling(n))
            test_bootsample(bs, ref, city2, n)
        end

        @testset "Residual resampling with link function" begin
            bs = bootstrap(coef, city2,
                           Model(GeneralizedLinearModel, @formula(thirty ~ twenty), Normal(), IdentityLink(), maxIter = max_iter, convTol = conv_tol),
                           ResidualSampling(n))
            test_bootsample(bs, ref, city2, n)
        end

        @testset "Wild resampling: Rademacher" begin
            bs = bootstrap(coef, city2,
                           Model(GeneralizedLinearModel, @formula(thirty ~ twenty), Normal(), maxIter = max_iter, convTol = conv_tol),
                           WildSampling(n, rademacher))
            test_bootsample(bs, ref, city2, n)
            @test isa( noise(sampling(bs)), Function )
        end

        @testset "Wild resampling with link function: Mammen" begin
            bs = bootstrap(coef, city2,
                           Model(GeneralizedLinearModel, @formula(thirty ~ twenty), Normal(), IdentityLink(), maxIter = max_iter, convTol = conv_tol),
                           WildSampling(n, mammen))
            test_bootsample(bs, ref, city2, n)
            @test isa( noise(sampling(bs)), Function )
        end

    end

end

end
