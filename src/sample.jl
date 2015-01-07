function sample_exact(n::Integer)
    return imap(sample_set, combinations([1:(2n-1)], n))
end

function sample_set(c::Array) ## Integer,1
    v = Array(Int, length(c))
    j = 1
    p = 1
    for k=1:length(c)
        while !(j in c)
            j += 1
            p += 1
        end
        v[k] = p
        j += 1
    end
    return v
end

### Sampling methods for 'DataFrame'

function sample(df::DataFrame, n::Integer; replace::Bool=true, ordered::Bool=false)
    index = sample(1:nrow(df), n, replace = replace, ordered = ordered)
    df[index,:]
end

function sample(df::DataFrame, wv::WeightVec, n::Integer; replace::Bool=true, ordered::Bool=false)
    index = sample(1:nrow(df), wv, n, replace = replace, ordered = ordered)
    df[index,:]
end


### Sampling methods for 'Array'

function sample{T}(a::AbstractArray{T}, d::Integer, n::Integer; replace::Bool=true, ordered::Bool=false)
    index = sample(1:size(a, d), n, replace = replace, ordered = ordered)
    a = slicedim(a, d, index)
    return a
end

