using Bootstrap
using Base.Test


nSamples = 50;

## sample data
r = randn(20);
w = rand(length(r));

## statistic functions
fun = mean

function test_boot(bs::BootstrapSample, r::Any, b::Symbol, f::Function)
    ## testing
    ## return type
    @test isa(bs, BootstrapSample)
    ## estimate t0
    @test length(estimate(bs)) == 1
    @test estimate(bs) == f(r)
    ## straps t1
    @test length(straps(bs)) > 1
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
end


function test_ci(bci::BootstrapCI, bs::BootstrapSample, c::Symbol)
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

function test_all_ci(bs, ci_funs, ci_methods)
    for (cif, cim) in zip(ci_funs, ci_methods)
        test_ci(cif(bs1), bs1, cim)
        test_ci(ci(bs1, method = cim), bs1, cim)
    end
end

ci_funs = (ci_basic, ci_normal, ci_perc)
ci_methods = (:basic, :normal, :perc) 

## boot_basic
bs1 = boot_basic(r, fun, nSamples);
bs2 = boot(r, fun, nSamples, method = :basic);
test_boot(bs1, r, :basic, fun);
test_boot(bs2, r, :basic, fun);
test_all_ci(bs1, ci_funs, ci_methods)

## boot_balanced
bs1 = boot_balanced(r, fun, nSamples);
bs2 = boot(r, fun, nSamples, method = :balanced);
test_boot(bs1, r, :balanced, fun);
test_boot(bs2, r, :balanced, fun);
test_all_ci(bs1, ci_funs, ci_methods)

## boot_weight
bs1 = boot_weight(r, fun, nSamples, WeightVec(w));
test_boot(bs1, r, :weighted, fun)
test_all_ci(bs1, ci_funs, ci_methods)

## boot_exact
r2 = randn(6);
bs1 = boot_exact(r2, fun)
bs2 = boot(r2, fun, 0, method = :exact)
test_boot(bs1, r2, :exact, fun)
test_boot(bs2, r2, :exact, fun)
test_all_ci(bs1, ci_funs, ci_methods)


### DataFrames

using DataFrames
df = DataFrame(a = r, b = reverse(r));
fun_df(x::DataFrame; column::Symbol = :a) = mean(x[:,column])

@test fun(r) == fun_df(df)

## boot_basic
bs1 = boot_basic(df, fun_df, nSamples)
test_boot(bs1, df, :basic, fun_df);
test_all_ci(bs1, ci_funs, ci_methods)

## boot_balanced
bs1 = boot_balanced(df, fun_df, nSamples)
test_boot(bs1, df, :balanced, fun_df)
test_all_ci(bs1, ci_funs, ci_methods)

## boot_weight
bs1 = boot_weight(df, fun_df, nSamples, WeightVec(w))
test_boot(bs1, df, :weighted, fun_df)
test_all_ci(bs1, ci_funs, ci_methods)

## boot_exact
df2 = DataFrame(a = randn(6));
bs1 = boot_exact(df2, fun_df)
test_boot(bs1, df2, :exact, fun_df)
test_all_ci(bs1, ci_funs, ci_methods)


### Arrays
## example taken from https://github.com/julian-gehring/Bootstrap.jl/issues/2
y = randn(25, 2);
mu_hat = mean(y, 1)
fun_array(x::AbstractArray) = norm(mean(x) - mu_hat)
fun_array(y)

## boot_basic
bs1 = boot_basic(y, fun_array, nSamples, 1)
test_boot(bs1, y, :basic, fun_array)

### check if unknown method is caught
@test_throws ErrorException boot(randn(10), mean, 100, method = :unknown)

bs = boot(randn(10), mean, 100, method = :basic);
@test_throws ErrorException ci(bs, method = :unknown)


### check return value
@test Bootstrap.checkReturn(1) == 1
@test_throws ErrorException Bootstrap.checkReturn([1:2])
@test_throws ErrorException Bootstrap.checkReturn(rand(2, 2))
