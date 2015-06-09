"""
**Arguments**

* `x` : AbstractVector
* `fun` : Function
* `m` : Int

**Keyword Arguments**

* `method` : Symbol (:basic)

**Returns**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot(randn(20), mean, 100, method = :basic)
```

"""
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

### boot_basic ###
"""
Ordinary bootstrapping by resampling with replacement.  This resamples the data `x` `m`-times and compute an estimate through the function `fun` each time. 

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `m` : Int
* `dim` : Int

**Returns**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot_basic(randn(20), mean, 100)
```

"""
:boot_basic

function boot_basic(x::AbstractVector, fun::Function, m::Int)
    n = length(x)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    boot_sample = zeros(x)
    for i in 1:m
        t1[i] = fun(sample!(x, boot_sample))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :basic)

    return res
end

"""

** Examples**

```julia
using DataFrames
df = DataFrame(a = randn(10), b = randn(10))
fun(x::DataFrame) = median(df[:,:a] - df[:,:b])
bs = boot_basic(df, fun, 100)
```

"""
function boot_basic(x::DataFrames.DataFrame, fun::Function, m::Int)
    n = nrow(x)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    for i in 1:m
        t1[i] = fun(sample(x, n, replace = true))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :basic)

    return res
end


"""

**Examples**

```julia
a = randn(5, 2)
fun(x::AbstractArray) = median(x[:,1] - x[:,2])
bs = boot_basic(a, fun, 100)
```

"""
function boot_basic(x::AbstractArray, fun::Function, m::Int, dim::Int = 1)
    n = size(x, dim)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    index = [1:n;]
    boot_index = zeros(Int, n)
    for i in 1:m
        sample!(index, boot_index)
        t1[i] = fun(slicedim(x, dim, boot_index))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :basic)

    return res
end


### boot_weight ###
"""
Weighted bootstrapping by weighted resampling with replacement.  This resamples the data `x` `m`-times with weights `w` and compute an estimate through the function `fun` each time. 

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `m` : Int
* `weight` : WeightVec from the 'StatsBase' package
* `dim` : Int

**Returns**

Object of class `BootstrapSample`

**Examples**

```julia
using StatsBase
bs = boot_weight(randn(20), mean, 100, WeightVec(rand(20)))
```

"""
:boot_weight

function boot_weight(x::AbstractVector, fun::Function, m::Int, weight::WeightVec)
    n = length(x)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    boot_sample = zeros(x)
    for i in 1:m
        t1[i] = fun(sample!(x, weight, boot_sample))
    end
    res = BootstrapSample(t0, t1, fun, x, m, weight, :weighted)

    return res
end

function boot_weight(x::DataFrames.DataFrame, fun::Function, m::Int, weight::WeightVec)
    n = nrow(x)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    for i in 1:m
        t1[i] = fun(sample(x, weight, n, replace = true))
    end
    res = BootstrapSample(t0, t1, fun, x, m, weight, :weighted)

    return res
end

function boot_weight(x::AbstractArray, fun::Function, m::Int, weight::WeightVec, dim::Int = 1)
    n = size(x, dim)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    index = [1:n;]
    boot_index = zeros(Int, n)
    for i in 1:m
        sample!(index, weight, boot_index)
        t1[i] = fun(slicedim(x, dim, boot_index))
    end
    res = BootstrapSample(t0, t1, fun, x, m, weight, :weighted)

    return res
end


### boot_balanced ###
"""
Balanced bootstrapping resampling with replacement.  This resamples the data `x` `m`-times, such that the original frequency of observations is retained through over all resamplings, and compute an estimate through the function `fun` each time. Balanced resampling is a good strategy if the observations are correlated.

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `m` : Int
* `dim` : Int

**Returns**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot_balanced(randn(20), mean, 100)
```

"""
function boot_balanced(x::AbstractVector, fun::Function, m::Int)
    n = length(x)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    idx = repmat([1:n;], m)
    ridx = zeros(Integer, n, m)
    sample!(idx, ridx, replace = false)
    for i in 1:m
        t1[i]= fun(x[ridx[:,i]])
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :balanced)

    return res
end

function boot_balanced(x::DataFrames.DataFrame, fun::Function, m::Int)
    n = nrow(x)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    idx = repmat([1:n;], m)
    ridx = zeros(Integer, n, m)
    sample!(idx, ridx, replace = false)
    for i in 1:m
        t1[i]= fun(x[ridx[:,i],:])
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :balanced)

    return res
end

function boot_balanced(x::AbstractArray, fun::Function, m::Int, dim::Int = 1)
    n = size(x, dim)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    idx = repmat([1:n;], m)
    ridx = zeros(Integer, n, m)
    sample!(idx, ridx, replace = false)
    for i in 1:m
        t1[i]= fun(slicedim(x, dim, ridx[:,i]))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :balanced)

    return res
end


### boot_exact ###
"""
The exact bootstrap resamples the data `x` such that all possible permutations with replacement are chosen, and compute an estimate through the function `fun` each time. This is only suited for small sample sizes since the number of permutations grows fast.

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `dim` : Int

**Returns**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot_exact(randn(6), mean)
```

"""
function boot_exact(x::AbstractVector, fun::Function)
    n = length(x)
    t0 = checkReturn(fun(x))
    m = binomial(2*n-1, n)
    t1 = zeros(typeof(t0), m)
    for (i, s) in enumerate(sample_exact(n))
        t1[i] = fun(x[s])
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :exact)

    return res
end

function boot_exact(x::DataFrames.DataFrame, fun::Function)
    n = nrow(x)
    t0 = checkReturn(fun(x))
    m = binomial(2*n-1, n)
    t1 = zeros(typeof(t0), m)
    for (i, s) in enumerate(sample_exact(n))
        t1[i] = fun(x[s,:])
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :exact)

    return res
end

function boot_exact(x::AbstractArray, fun::Function, dim::Int = 1)
    n = size(x, dim)
    t0 = checkReturn(fun(x))
    m = binomial(2*n-1, n)
    t1 = zeros(typeof(t0), m)
    for (i, s) in enumerate(sample_exact(n))
        t1[i] = fun(slicedim(x, dim, s))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :exact)

    return res
end
