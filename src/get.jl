"""
Estimate the bias of a bootstrap sampling.
"""
bias(t0, t1::AbstractVector) = mean(t1) - t0

bias(bs::BootstrapSample) = [bias(t0, t1) for (t0, t1) in zip(bs.t0, bs.t1)]


"""
Estimate the standard error of a bootstrap sampling.
"""
se(t1::AbstractVector) = std(t1)

se(bs::BootstrapSample) = [se(t1) for t1 in bs.t1]


original(bs::BootstrapSample) = bs.t0

straps(bs::BootstrapSample) = bs.t1

data(bs::BootstrapSample) = bs.data

model(bs::ParametricBootstrapSample) = bs.model

sampling(bs::BootstrapSample) = bs.sampling
