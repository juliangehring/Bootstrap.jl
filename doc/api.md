# Bootstrap


## Methods [Exported]

---

<a id="method__bias.1" class="lexicon_definition"></a>
#### bias(bs::BootstrapSample{E, S, D})
Estimate the bias of a bootstrap sampling.


---

<a id="method__boot.1" class="lexicon_definition"></a>
#### boot(x::AbstractArray{T, 1}, fun::Function, m::Int64)
**Arguments**

* `x` : AbstractVector
* `fun` : Function
* `m` : Int

**Keyword Arguments**

* `method` : Symbol (:basic)

**Return value**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot(randn(20), mean, 100, method = :basic)
```



---

<a id="method__boot_balanced.1" class="lexicon_definition"></a>
#### boot_balanced(x::AbstractArray{T, 1}, fun::Function, m::Int64)
Balanced bootstrapping resampling with replacement.  This resamples the data `x` `m`-times, such that the original frequency of observations is retained through over all resamplings, and compute an estimate through the function `fun` each time. Balanced resampling is a good strategy if the observations are correlated.

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `m` : Int
* `dim` : Int

**Return value**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot_balanced(randn(20), mean, 100)
```



---

<a id="method__boot_basic.1" class="lexicon_definition"></a>
#### boot_basic(x::AbstractArray{T, 1}, fun::Function, m::Int64)
Ordinary bootstrapping by resampling with replacement.  This resamples the data `x` `m`-times and compute an estimate through the function `fun` each time. 

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `m` : Int
* `dim` : Int

**Return value**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot_basic(randn(20), mean, 100)
```



---

<a id="method__boot_basic.2" class="lexicon_definition"></a>
#### boot_basic(x::AbstractArray{T, N}, fun::Function, m::Int64)

**Examples**

```julia
a = randn(5, 2)
fun(x::AbstractArray) = median(x[:,1] - x[:,2])
bs = boot_basic(a, fun, 100)
```



---

<a id="method__boot_basic.3" class="lexicon_definition"></a>
#### boot_basic(x::AbstractArray{T, N}, fun::Function, m::Int64, dim::Int64)

**Examples**

```julia
a = randn(5, 2)
fun(x::AbstractArray) = median(x[:,1] - x[:,2])
bs = boot_basic(a, fun, 100)
```



---

<a id="method__boot_basic.4" class="lexicon_definition"></a>
#### boot_basic(x::DataFrame, fun::Function, m::Int64)

** Examples**

```julia
using DataFrames
df = DataFrame(a = randn(10), b = randn(10))
fun(x::DataFrame) = median(df[:,:a] - df[:,:b])
bs = boot_basic(df, fun, 100)
```



---

<a id="method__boot_exact.1" class="lexicon_definition"></a>
#### boot_exact(x::AbstractArray{T, 1}, fun::Function)
This resamples the data `x` such that all possible permutations with replacement are chosen, and compute an estimate through the function `fun` each time. This is only suited for small sample sizes (<= 8) since the number of permutations grows fast.

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `dim` : Int

**Return value**

Object of class `BootstrapSample`

**Examples**

```julia
bs = boot_exact(randn(6), mean)
```



---

<a id="method__boot_weight.1" class="lexicon_definition"></a>
#### boot_weight(x::AbstractArray{T, 1}, fun::Function, m::Int64, weight::WeightVec{W, Vec<:AbstractArray{T<:Real, 1}})
Weighted bootstrapping by weighted resampling with replacement.  This resamples the data `x` `m`-times with weights `w` and compute an estimate through the function `fun` each time. 

**Arguments**

* `x` : AbstractVector, AbstracArray, DataFrame
* `fun` : Function
* `m` : Int
* `weight` : WeightVec from the 'StatsBase' package
* `dim` : Int

**Return value**

Object of class `BootstrapSample`

**Examples**

```julia
using StatsBase
bs = boot_weight(randn(20), mean, 100, WeightVec(rand(20)))
```



---

<a id="method__data.1" class="lexicon_definition"></a>
#### data(bs::BootstrapSample{E, S, D})
Return the original data from a bootstrap sampling.


---

<a id="method__estimate.1" class="lexicon_definition"></a>
#### estimate(bs::BootstrapCI{E})
Return the raw estimate `t0`, calculated by `fun(data)`, from a bootstrap confidence interval.


---

<a id="method__estimate.2" class="lexicon_definition"></a>
#### estimate(bs::BootstrapSample{E, S, D})
Return the raw estimate `t0`, calculated by `fun(data)`, from a bootstrap sampling.


---

<a id="method__interval.1" class="lexicon_definition"></a>
#### interval(bs::BootstrapCI{E})
Return the lower and upper bound of the confidence interval.


---

<a id="method__level.1" class="lexicon_definition"></a>
#### level(bs::BootstrapCI{E})
Return the confidence level [0, 1] of a bootstrap confidence interval.


---

<a id="method__method.1" class="lexicon_definition"></a>
#### method(bs::BootstrapCI{E})
Return the confidence interval method as a symbol from a bootstrap confidence interval.


---

<a id="method__method.2" class="lexicon_definition"></a>
#### method(bs::BootstrapSample{E, S, D})
Return the sampling method as a symbol from a bootstrap sampling.


---

<a id="method__se.1" class="lexicon_definition"></a>
#### se(bs::BootstrapSample{E, S, D})
Estimate the standard error of a bootstrap sampling.


---

<a id="method__straps.1" class="lexicon_definition"></a>
#### straps(bs::BootstrapSample{E, S, D})
Return the bootstrapped estimates `t1`from a bootstrap sampling.


---

<a id="method__width.1" class="lexicon_definition"></a>
#### width(x::BootstrapCI{E})
Return the width of a bootstrap confidence interval, given by the difference of the upper and lower bound.


## Types [Exported]

---

<a id="type__bootstrapci.1" class="lexicon_definition"></a>
#### BootstrapCI{E}
Class `BootstrapCI` that stores the result of a bootstrap-based confidence interval.  An object of this class is returned by the `ci` functions.


---

<a id="type__bootstrapsample.1" class="lexicon_definition"></a>
#### BootstrapSample{E, S, D}
Class `BootstrapSample` that stores the result of a bootstrap sampling.  An object of this class is returned by the `boot` functions.


