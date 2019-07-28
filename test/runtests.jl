tests = ["test-bootsample-non-parametric",
         "test-bootsample-parametric",
         "test-bootsample-dependent",
         "test-utils",
         "test-dependencies"]

for t in tests
    test_file = "$(t).jl"
    include(test_file)
end
