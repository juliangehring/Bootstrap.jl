function boot_basic_lm(x::AbstractArray, fun::Function, m::Int, dim::Int = 1)
    n = size(x, dim)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    index = 1:n
    #inds = [1:i for i in size(x)]
    boot_index = zeros(Int, n)
    for i in 1:m
        sample!(index, boot_index)
        inds = [ j==dim ? boot_index : (1:size(x,j)) for j in 1:ndims(x) ]
        #inds[dim] = boot_index
        t1[i] = fun(sub(x, inds...))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :basic)

    return res
end

function boot_basic_lm2(x::AbstractArray, fun::Function, m::Int, dim::Int = 1)
    n = size(x, dim)
    t0 = checkReturn(fun(x))
    t1 = zeros(typeof(t0), m)
    index = 1:n
    inds = [1:i for i in size(x)]
    boot_index = zeros(Int, n)
    for i in 1:m
        sample!(index, boot_index)
        #inds = [ j==dim ? boot_index : (1:size(x,j)) for j in 1:ndims(x) ]
        inds[dim] = boot_index
        t1[i] = fun(sub(x, inds...))
    end
    res = BootstrapSample(t0, t1, fun, x, m, 0, :basic)

    return res
end
