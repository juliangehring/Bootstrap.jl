function jack_knife_estimate(x::AbstractVector, fun::Function)
    n = length(x)
    y = zeros(n)
    idx = trues(n)
    for i in 1:n
        idx[i] = false
        if i > 1
            idx[i-1] = true
        end
        y[i] = fun(x[idx])
    end
    return y
end

function jack_knife_estimate(x::DataFrame, fun::Function)
    n = nrow(x)
    y = zeros(n)
    idx = trues(n)
    for i in 1:n
        idx[i] = false
        if i > 1
            idx[i-1] = true
        end
        y[i] = fun(x[idx,:])
    end
    return y
end

