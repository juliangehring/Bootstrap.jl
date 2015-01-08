using Bootstrap
using Base.Test

nSamples = 100;

## sample data
rn = randn(20);
ru = rand(20);
r_data = (rn, ru);

## statistic functions
funs = (mean, median)
b_methods = (:basic, :balanced)
ci_methods = (:basic, :perc, :normal)

for r in r_data, f in funs, b in b_methods
    bs = boot(r, f, nSamples, method = b)
    ## testing
    ## return type
    @test isa(bs, BootstrapSample)
    ## estimate t0
    @test length(estimate(bs)) == 1
    @test estimate(bs) == f(r)
    ## straps t1
    @test length(straps(bs)) == nSamples
    ## data
    @test data(bs) == r
    ## accessors
    @test method(bs) == b
    ## bias and se
    @test bias(bs) > -1.0 && bias(bs) < 1.0
    @test se(bs) > 0
    ## show method
    io_tmp = IOBuffer()
    @test length(takebuf_string(io_tmp)) == 0
    show(io_tmp, bs)
    @test length(takebuf_string(io_tmp)) > 0
    close(io_tmp)
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
        ## show method
        io_tmp = IOBuffer()
        @test length(takebuf_string(io_tmp)) == 0
        show(io_tmp, bci)
        @test length(takebuf_string(io_tmp)) > 0
        close(io_tmp)
    end
end

## small version for boot_exact
nSamples = 0;  ## not used

## sample data
ru = rand(6);
r_data = (ru, );

## statistic functions
funs = (mean, median)
b_methods = (:exact, )
ci_methods = (:basic, :perc, :normal)

for r in r_data, f in funs, b in b_methods
    bs = boot(r, f, nSamples, method = b)
    ## testing
    ## return type
    @test isa(bs, BootstrapSample)
    ## estimate t0
    @test length(estimate(bs)) == 1
    @test estimate(bs) == f(r)
    ## straps t1
    @test length(straps(bs)) > 1
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

## check if unknown method is caught
@test_throws ErrorException boot(randn(10), mean, 100, method = :unknown)

bs = boot(randn(10), mean, 100, method = :basic);
@test_throws ErrorException ci(bs, method = :unknown)
