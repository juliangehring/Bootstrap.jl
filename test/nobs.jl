module Test_nobs

## nobs
using Bootstrap
using Base.Test

n = 5

## Vector
x = randn(n)
@test Bootstrap.nobs(x) == n

## Array
x = randn(n, 2n)
@test Bootstrap.nobs(x) == n
@test Bootstrap.nobs(x, 1) == n
@test Bootstrap.nobs(x, 2) == 2n

## DataFrame
using DataFrames
x = DataFrame(x = randn(n), y = randn(n))
@test Bootstrap.nobs(x) == n

end
