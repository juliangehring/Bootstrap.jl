### Number of observations ###

nobs(x::AbstractVector) = length(x)

nobs(x::AbstractArray, dim::Integer = 1) = size(x, dim)

nobs(x::DataFrames.AbstractDataFrame) = nrow(x)
