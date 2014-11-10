tests = ["boot",
         "distributions-dep"]

println("Running 'Bootstrap' tests:")

for t in tests
    test_file = string(t, ".jl")
    if !isfile(test_file)
        warn(" ! $(test_file) missing")
    end
    println(" * $(test_file) ...")
    include(test_file)
end
