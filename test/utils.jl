module TestUtils

using Bootstrap
using Base.Test


@testset "Statistic functions" begin

    x = collect(100:-1:0) ## avoid sorting

    ## reference values, computed with boot:::norm_inter (R)
    qr = (
        (1.0,      Inf),
        (0.0,     -Inf),
        (0.5,     50.0),
        (0.4713,  47.07265),
        (0.1,      9.205641),
        (0.052,    4.319606)
    )

    @testset "Normal-interpolated quantiles" begin

        @testset "Reference values: alpha scalar" begin
            for (alpha, ref) in qr
                @test isapprox( Bootstrap.iquantile(x, alpha), ref, atol = 1e-5 )
            end
        end

        @testset "Reference values: alpha vector" begin
            a = Float64[x[1] for x in qr]
            r = Float64[x[2] for x in qr]
            y = Bootstrap.iquantile(x, a)
            @test isapprox(y, r, atol = 1e-4 )
        end

        @testset "Monotone quantiles" begin
            x = collect(0:100)
            ## check that quantiles are monotone
            y0 = -Inf
            for alpha in 0:0.001:1
                y1 = Bootstrap.iquantile(x, alpha)
                @test y1 >= y0
                y0 = y1
            end
        end

    end

end


@testset "Utility functions" begin

    @testset "Exact sampling" begin

        mss = collect(Bootstrap.exact(4))
        @test length(mss) == 35
        @test reduce(&, [issorted(c) for c in mss])

        for n in 1:6
            @test length(Bootstrap.exact(n)) == Bootstrap.nrun_exact(n)
        end

    end

end

end
