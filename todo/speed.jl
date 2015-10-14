
function foobar(x, nrun, statistic)
    model = LinearModel
    formula = Surv ~ Dose
    yy = :Surv
    n = nrow(x)
    r0 = randn(n)
    r1 = copy(r0)
    data1 = deepcopy(x)
    t1 = zeros(nrun)
    f1 = fit(model, formula, data1)
    for i in 1:nrun
        sample!(r0, r1)
        data1[:,yy] = r0 + r1
        f1 = fit(model, formula, data1)
        t1[i] = statistic(f1)
    end
    return t1
end

@time foobar(surv, 1000, slope);
## n: 1000
## full: 0.165652 seconds (339.05 k allocations: 31.047 MB, 1.61% gc time)
## w/o sample!: 0.174539 seconds (339.05 k allocations: 31.047 MB, 1.61% gc time)
## w/o data1: 0.197007 seconds (333.05 k allocations: 30.711 MB, 1.58% gc time)
## w/o fit: 0.006245 seconds (8.38 k allocations: 417.047 KB) !!!!!

## glm general
srand(1)
X = rand(10, 2)
Y = logistic(X * [3; -3])
@time gm3 = glm(X, Y, Binomial(); dofit = false)

fit!(gm3)


function foobar2(X, Y, nrun, statistic)
    n = size(X, 1)
    r0 = randn(n)
    r1 = copy(r0)
    t1 = zeros(nrun)
    f0 = glm(X, Y, Normal(); dofit = false)
    fit!(f0)
    for i in 1:nrun
        sample!(r0, r1)
        f0.rr.y = Y + r1
        f0.fit = false
        fit!(f0)
        t1[i] = statistic(f0)
    end
    return t1
end

function foobar3(X, Y, nrun, statistic)
    n = size(X, 1)
    r0 = randn(n)
    r1 = copy(r0)
    t1 = zeros(nrun)
    f0 = glm(X, Y, Normal())
    for i in 1:nrun
        sample!(r0, r1)
        f0 = glm(X, Y + r1, Normal())
        t1[i] = statistic(f0)
    end
    return t1
end


@time foobar2(X, Y, 10000, slope);

@time foobar3(X, Y, 10000, slope);
