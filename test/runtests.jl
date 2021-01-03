tests = ["test-non-parametric",
         "test-parametric",
         "test-utils",
         "test-dependencies"]

for t in tests
    test_file = "$(t).jl"
    include(test_file)
end
