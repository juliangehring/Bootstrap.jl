using Bootstrap
using Base.Test

nSamples = 100;

## sample data
rn = randn(100);
ru = rand(20);
data = (rn, ru);

## statistic functions
funs = (mean, median)
b_methods = (:basic, :balanced)
ci_methods = (:basic, :perc, :normal)

for r in data, f in funs, b in b_methods
    bs = boot(r, f, nSamples, method = b)
    ## testing
    ## return type
    @test isa(bs, BootstrapSample)
    ## estimate t0
    @test length(estimate(bs)) == 1
    @test estimate(bs) == f(r)
    ## straps t1
    @test length(straps(bs)) == nSamples
    ## accessors
    @test method(bs) == b
    ## bias and se
    @test bias(bs) > -1.0 && bias(bs) < 1.0
    @test se(bs) > 0
    ## confidence intervals
    for c in ci_methods
        bci = ci(bs, method = c)
        ## testing
        ## return type
        @test isa(bci, BootstrapCI)
        ## estimate
        @test estimate(bci) == estimate(bs)
        ## accessors
        @test method(bci) == c
        ## default level
        @test level(bci) == 0.95
        ## CI bounds: interval
        @test interval(bci)[1] < estimate(bci)
        @test interval(bci)[2] > estimate(bci)
    end
end


### test dependencies ###

## Distributions
using Distributions

## reference values, taken from qnorm [R]
qnorm = (
         (0.1, -1.281552),
         (0.5, 0),
         (0.9, 1.281552),
         (0.95, 1.644854),
         (0.99, 2.326348)
         )

for (alpha, ref) in qnorm
    v = quantile(Normal(), alpha)
    @test_approx_eq_eps(v, ref, 1e-6)
end
