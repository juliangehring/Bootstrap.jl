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
