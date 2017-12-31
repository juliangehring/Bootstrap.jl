tests = ["bootsample-non-parametric",
         "bootsample-parametric",
         "utils",
         "distributions-dep"]

for t in tests
    test_file = "$(t).jl"
    include(test_file)
end
