@doc """
# Type 'BootstrapSample'

## Definition

`BootstrapSample{E,S,D}`

## Fields

- `t0 {E}`: Raw estimate, as given by `fun(x)`

- `t1 {S}`: Bootstrapped estimates, also referred to as 'straps' here. A high-order o
bject of type `S` with `m` elements, e.g. an `Array{Float64,1}` if `fun(x)` returned a `Float64`.

- `x {D}`: Input data of type `D`. Currently, the types `AbstractVector`, `AbstractArray`, `DataFrame` are supported.

- `m {Integer}`: The number of bootstrap samples that are computed

- `fun {Function}`: Function to obtain the estimate given the data `x`. Note that at the moment, only `x` is passed to the function; additional arguments must be provided within the function or given as defaults. That means that function definition should look something like `fun(x) = ...`

- `method {Symbol}`: The method/approach that is used for sampling the bootstrap estimates.

## Notes

An object of this type is returned by any of the 'boot*' methods. There is no good reason to construct one manually.

""" ->
type BootstrapSample{E,S,D}
    t0::E
    t1::S
    fun::Function
    x::D
    m::Integer
    wv
    method::Symbol
end

#bs = BootstrapSample(1.0, [1.0, 1.1, 1.2], mean, [1, 2, 3], 3, :basic)

function bias(bs::BootstrapSample)
    b = mean(bs.t1) - bs.t0
    return b
end

function se(bs::BootstrapSample)
    v = std(bs.t1)
    return v
end

function estimate(bs::BootstrapSample)
    return bs.t0
end

function straps(bs::BootstrapSample)
    return bs.t1
end

function data(bs::BootstrapSample)
    return bs.x
end

function method(bs::BootstrapSample)
    return bs.method
end

type BootstrapCI
    t0
    lower
    upper
    level::FloatingPoint
    method::Symbol
end

function estimate(bs::BootstrapCI)
    return bs.t0
end

function interval(bs::BootstrapCI)
    return [bs.lower, bs.upper]
end

function level(bs::BootstrapCI)
    return bs.level
end

function method(bs::BootstrapCI)
    return bs.method
end
