### check return value
function checkReturn{T}(x::T)
    length(x) != 1 ? error("Return value must be a scalar.") : x
end


function jack_knife_estimate(x::AbstractVector, fun::Function, typ::Type = typeof(fun(x)))
    n = length(x)
    y = zeros(typ, n)
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

function jack_knife_estimate(x::DataFrames.DataFrame, fun::Function, typ::Type = typeof(fun(x)))
    n = nrow(x)
    y = zeros(typ, n)
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
