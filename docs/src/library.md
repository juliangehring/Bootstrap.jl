# Library

```@meta
CurrentModule = Bootstrap
DocTestSetup = quote
    using Bootstrap
end
```


## Sampling

### Sampling Types

```@docs
BasicSampling
BalancedSampling
ExactSampling
ResidualSampling
WildSampling
MaximumEntropySampling
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
