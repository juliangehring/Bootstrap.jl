tests = ["boot",
         "distributions-dep",
         "sampling",
         "doctest"]

println("Running 'Bootstrap' tests:")

for t in tests
    test_file = string(t, ".jl")
    if !isfile(test_file)
        error(" ! $(test_file) missing")
    end
    println(" * $(test_file) ...")
    include(test_file)
end
