function boot(x::AbstractVector, fun::Function, m::Int; method::Symbol = :basic)

    if method == :basic
        boot_basic(x, fun, m)
    #elseif method == :weight
    #    boot_weight(x, fun, m, weight)
    elseif method == :balanced
        boot_balanced(x, fun, m)
    elseif method == :exact
        boot_exact(x, fun)
    else
        error("Method '$(method)' is not implemented")
    end

end


function boot_basic(x::AbstractVector, fun::Function, m::Int)
    n = length(x)
    t0 = fun(x)
    t1 = zeros(m)
    for i in 1:m
        t1[i] = fun(sample(x, n, replace = true))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :basic)

    return res
end


function boot_weight(x::AbstractVector, fun::Function, m::Int, weight::WeightVec)
    n = length(x)
    t0 = fun(x)
    t1 = zeros(m)
    for i in 1:m
        t1[i] = fun(sample(x, weight, n, replace = true))
    end
    res = BootstrapSample(t0, t1, fun, x, m, weight, :weighted)

    return res
end


function boot_balanced(x::AbstractVector, fun::Function, m::Int)
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
    res = BootstrapSample(t0, t1, fun, x, m, 0, :balanced)

    return res
end


function boot_exact(x::AbstractVector, fun::Function)
    n = length(x)
    t0 = fun(x)
    m = binomial(2*n-1, n)
    t1 = zeros(m)
    for (i, s) in enumerate(sample_exact(n))
        t1[i] = fun(x[s])
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :exact)

    return res
end
