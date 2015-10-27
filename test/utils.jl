module TestUtils

using Bootstrap
using Base.Test

## exact sampling

mss = collect(Bootstrap.exact(4))
@test length(mss) == 35
@test reduce(&, [issorted(c) for c in mss])

for n in 1:6
    @test length(Bootstrap.exact(n)) == Bootstrap.nrun_exact(n)
end

end
