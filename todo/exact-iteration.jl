type ExactIterator
    inneritr::Base.Combinations{Array{Int64,1}}
    n::Int
end

exact(n::Int) = ExactIterator(combinations(collect(1:(2n-1)), n), n)

eltype(itr::ExactIterator) = Array{Int64, 1}

start(itr::ExactIterator) = start(itr.inneritr)

function next(itr::ExactIterator, s)
    c, s = next(itr.inneritr, s)
    v = Array(Int, itr.n)
    j = 1
    p = 1
    for k = 1:itr.n
        while !(j in c)
            j += 1
            p += 1
        end
        v[k] = p
        j += 1
    end
    return v, s
end

done(itr::ExactIterator, s) = done(itr.inneritr, s)

length(itr::ExactIterator) = length(itr.inneritr)


type ExactIterator2
    inneritr::Base.Combinations{Array{Int64,1}}
    n::Int
end

exact2(n::Int) = ExactIterator2(combinations(collect(1:(2n-1)), n-1), n)

function next(itr::ExactIterator2, s)
    (c, s) = next(itr.inneritr, s)
    c3 = [c, 2*itr.n; ] .- [0, c; ]
    (vcat([fill(i, c3[itr.n-i+1]-1) for i = 1:itr.n]...), s)
end

done(itr::ExactIterator2, s) = done(itr.inneritr, s)

length(itr::ExactIterator2) = length(itr.inneritr)

eltype(itr::ExactIterator2) = Array{Int64, 1}

start(itr::ExactIterator2) = start(itr.inneritr)

using Iterators

function sample_set(c::Array) ## Integer,1
    v = Array(Int, length(c))
    j = 1
    p = 1
    for k = 1:length(c)
        while !(j in c)
            j += 1
            p += 1
        end
        v[k] = p
        j += 1
    end
    return v
end

function exact3(n::Integer)
    return imap(sample_set, combinations([1:(2n-1);], n))
end

@time s1 = collect(exact(12));
# n = 12: 2.58s, 6.76 M allocations: 711.773 MB

@time s2 = collect(exact2(12)); ## slow and much memory
# n = 12: 30.23s, 104.11 M allocations: 6.358 GB

@time s3 = collect(exact3(12));
# n = 12: 11.22s, 16.22 M allocations: 1.145 GB

sort([hash(x) for x in s1]) == sort([hash(x) for x in s2])

sort([hash(x) for x in s1]) == sort([hash(x) for x in s3])
