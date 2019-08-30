using SafeTestsets

@safetestset "Non-parametric bootstrap" begin include("test-bootsample-non-parametric.jl") end
@safetestset "Parametric bootstrap" begin include("test-bootsample-parametric.jl") end
@safetestset "Utilities" begin include("test-utils.jl") end
@safetestset "Dependencies" begin include("test-dependencies.jl") end