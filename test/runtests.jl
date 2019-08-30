using SafeTestsets

@safetestset "Non-parametric bootstrap" begin include("nonparametric.jl") end
@safetestset "Parametric bootstrap" begin include("parametric.jl") end
@safetestset "Utilities" begin include("utils.jl") end
@safetestset "Dependencies" begin include("dependencies.jl") end