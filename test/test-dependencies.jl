using Distributions
using Test

@testset "Distributions" begin

    ## reference values, taken from qnorm [R]
    qnorm = ((0.1, -1.281552),
         (0.5, 0.0),
         (0.9, 1.281552),
         (0.95, 1.644854),
         (0.99, 2.326348))

    for (alpha, ref) in qnorm
        v = quantile(Normal(), alpha)
        @test isapprox(v, ref, atol = 1e-6)
    end

end
