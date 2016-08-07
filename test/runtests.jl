tests = ["distributions-dep",
         "bootsample-non-parametric",
         "bootsample-parametric",
         "stats",
         "utils"]

println("Running 'Bootstrap' tests:")

test_dir = dirname(@__FILE__)

for t in tests
    test_file = joinpath(test_dir, string(t, ".jl"))
    if !isfile(test_file)
        error(" ! $(test_file) missing")
    end
    println(" * $(t) ...")
    include(test_file)
end
