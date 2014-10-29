function ci(x::BootstrapSample; level::FloatingPoint = 0.95, method::Symbol = :basic)

    if method == :basic
        ci_basic(x, level)
    elseif method == :perc
        ci_perc(x, level)
    else
        error("Method '$(method)' is not implemented")
    end
        
end


function ci_basic(x::BootstrapSample, level::FloatingPoint = 0.95)
    t0 = x.t0
    t1 = x.t1
    alpha = ([level, -level] + 1)/2
    lower, upper = quantile(t1, alpha)
    lower = 2 * t0 - lower
    upper = 2 * t0 - upper
    res = BootstrapCI(x.t0, lower, upper, level, :basic)
    return res
end

function ci_perc(x::BootstrapSample, level::FloatingPoint = 0.95)
    t1 = x.t1
    alpha = ([-level, level] + 1)/2
    lower, upper = quantile(t1, alpha)
    res = BootstrapCI(x.t0, lower, upper, level, :perc)
    return res
end

function ci_normal(x::BootstrapSample, level::FloatingPoint = 0.95)
    ## what are we missing here?
    bias = bias(x) ##bias = mean(t) - t0
    se = se(x)
    z = quantile(Normal(), (1+level)/2)
    merr = se * z
    lower = t0 - bias - merr
    upper = t0 - bias + merr
    res = BootstrapCI(x.t0, lower, upper, level, :normal)
    return res
end

function ci_stud(x::BootstrapSample)
    ## need var estimates for t0 and t1
    ## compute from data if not provided?
end

function ci_bca(x::BootstrapSample)
end

x = randn(10);

bs = boot_basic(x, mean, 100);

ci_basic(bs)

ci_perc(bs)
