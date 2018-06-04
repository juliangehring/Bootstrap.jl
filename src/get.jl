"""
Estimate the bias of a bootstrap sampling.

```julia
bs = bootstrap(randn(20), mean, BasicSampling(100))

bias(bs)
```

"""
bias(t0, t1::AbstractVector) = mean(t1) - t0

bias(bs::BootstrapSample) = [bias(t0, t1) for (t0, t1) in zip(original(bs), straps(bs))]

bias(bs::BootstrapSample, idx::Int) = bias(original(bs, idx), straps(bs, idx))

"""
Estimate the standard error of a bootstrap sampling.

```julia
bs = bootstrap(randn(20), mean, BasicSampling(100))

stderror(bs)
```

"""
stderror(t1::AbstractVector) = std(t1)

stderror(bs::BootstrapSample) = [stderror(t1) for t1 in straps(bs)]

stderror(bs::BootstrapSample, idx::Int) = stderror(straps(bs, idx))


original(bs::BootstrapSample) = bs.t0

original(bs::BootstrapSample, idx::Int) = original(bs)[idx]


straps(bs::BootstrapSample) = bs.t1

straps(bs::BootstrapSample, idx::Int) = straps(bs)[idx]


data(bs::BootstrapSample) = bs.data


model(bs::ParametricBootstrapSample) = bs.model


sampling(bs::BootstrapSample) = bs.sampling
