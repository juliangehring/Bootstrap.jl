module Bootstrap

using StatsBase
using Iterators

export
    ## types
    BootstrapSample,
    ## methods
    boot_basic,
    boot_weight,
    boot_balanced,
    boot_exact

include("classes.jl")
include("boot.jl")

end # module
