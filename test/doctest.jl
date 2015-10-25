module TestDoctest

## doctest
using Bootstrap
using Base.Test

if !haskey(Pkg.installed(), "Lexicon")
    Pkg.add("Lexicon")
end
using Lexicon

dt = doctest(Bootstrap);
@test length(failed(dt)) == 0

end
