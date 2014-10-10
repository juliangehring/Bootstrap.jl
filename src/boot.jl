function boot_basic(x, fun::Function, m::Int)
    n = length(x)
    t0 = fun(x)
    t1 = zeros(m)
    for i in 1:m
        t1[i] = fun(sample(x, n, replace = true))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, "basic")

    return res
end


function boot_weight(x, fun::Function, m::Int, weight::WeightVec)
    n = length(x)
    t0 = fun(x)
    t1 = zeros(m)
    for i in 1:m
        t1[i] = fun(sample(x, weight, n, replace = true))
    end
    res = BootstrapSample(t0, t1, fun, x, m, weight, "weighted")

    return res
end


function boot_balanced(x, fun::Function, m::Int)
    n = length(x)
    t0 = fun(x)
    t1 = zeros(m)
    idx = repmat([1:n], m)
    ridx = sample(idx, n*m, replace = false)
    ridx = reshape(ridx, n, m)
    if sum(idx) != sum(ridx)
        error("Sampling not balanced")
    end
    for i in 1:m
        t1[i]= fun(x[ridx[:,i]])
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, "balanced")

    return res
end


function boot_exact(x, fun::Function)
    n = length(x)
    if n > 8
        warn("'n' is very large:  Consider random sampling.")
    end
    t0 = fun(x)
    p = product( [x for i in 1:n]... )
    m = length(p)
    t1 = zeros(m)
    for (i, s) in enumerate(p)
        t1[i] = fun(s)
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, "exact")

    return res
end
