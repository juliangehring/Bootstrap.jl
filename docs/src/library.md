# Library

```@meta
CurrentModule = Bootstrap
DocTestSetup = quote
    using Bootstrap
end
```


## Sampling

### Non-Parametric Sampling

```@docs
BasicSampling
BalancedSampling
ExactSampling
AntitheticSampling
MaximumEntropySampling
```


### Parametric Sampling

```@docs
ResidualSampling
WildSampling
```


### Accessors

```@docs
nrun
statistic
noise
```


## Confidence Intervals

```@docs
BasicConfInt
PercentileConfInt
NormalConfInt
StudentConfInt
BCaConfInt
```
