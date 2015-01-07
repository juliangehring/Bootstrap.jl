using Bootstrap
using Base.Test

### Sampling of a DataFrame ###
using DataFrames
using StatsBase

m = 5
df = DataFrame(a = [1:5], b = [5:-1:1])
wv = WeightVec([1:5])

dfs = sample(df, m)
@test nrow(dfs) == m

dfu = sample(df, m, replace = false)
@test nrow(dfu) == m
@test Set(dfu[:,:a]) == Set(df[:,:a])

dfw = sample(df, wv, m)
@test nrow(dfw) == m

### Sampling of Arrays ###
a = rand(5, 3)
as = sample(a, 1, size(a, 1))
@test size(as) == size(a)
as = sample(a, 2, size(a, 2))
@test size(as) == size(a)
