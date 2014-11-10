tests = ["boot",
         "distributions-dep"]

println("Running 'Bootstrap' tests:")

for t in tests
    test_file = string(t, ".jl")
    println(" * $(test_file) ...")
    include(test_file)
end
