module Test_show

using Bootstrap
using Base.Test

x = 1::Int64
@test Bootstrap.data_summary(x) == "Int64: { 1 }"
x = Float32[1., 2., 3.]
@test Bootstrap.data_summary(x) == "Array{Float32,1}: { 3 }"
x = rand(Float64, 4, 3)
@test Bootstrap.data_summary(x) == "Array{Float64,2}: { 4 x 3 }"

end
