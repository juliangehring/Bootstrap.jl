module TestUtils

using Bootstrap
using FactCheck

facts("Exact sampling") do

    mss = collect(Bootstrap.exact(4))
    @fact length(mss) --> 35
    @fact reduce(&, [issorted(c) for c in mss]) --> true

    for n in 1:6
        @fact length(Bootstrap.exact(n)) --> Bootstrap.nrun_exact(n)
    end

end

end
