## still needed now that we can support formula?
function bootstrap(data, response, statistic::Function, model, sampling::BootstrapSampling; transform::Function = identity)
    f0 = fit(model, data, response)
    t0 = statistic(transform(f0))
    #r0 = predict(f0) - response
    r0 = resid(f0, response) # -> resid
    t1 = zeros(sampling.nrun)
    r1 = copy(r0)
    for i in 1:sampling.nrun
        sample!(r0, r1)
        f1 = fit(model, data, response + r1) # -> combine
        t1[i] = statistic(transform(f1))
    end
    return t0, t1
end
