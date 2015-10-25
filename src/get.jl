"""
Estimate the bias of a bootstrap sampling.
"""
bias(t0, t1::AbstractVector) = mean(t1) - t0

bias(bs::BootstrapSample) = [bias(t0, t1) for (t0, t1) in zip(original(bs), straps(bs))]

bias(bs::BootstrapSample, idx::Int) = bias(original(bs, idx), straps(bs, idx))

"""
Estimate the standard error of a bootstrap sampling.
"""
se(t1::AbstractVector) = std(t1)

se(bs::BootstrapSample) = [se(t1) for t1 in straps(bs)]

se(bs::BootstrapSample, idx::Int) = se(straps(bs, idx))


original(bs::BootstrapSample) = bs.t0

original(bs::BootstrapSample, idx::Int) = original(bs)[idx]


straps(bs::BootstrapSample) = bs.t1

straps(bs::BootstrapSample, idx::Int) = straps(bs)[idx]


data(bs::BootstrapSample) = bs.data


model(bs::ParametricBootstrapSample) = bs.model


sampling(bs::BootstrapSample) = bs.sampling
