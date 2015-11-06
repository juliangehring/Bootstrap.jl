module TestDoctest

## doctest
using Bootstrap
using FactCheck

using Lexicon

facts("Doctest") do
    dt = doctest(Bootstrap)
    @fact length(failed(dt)) --> 0
end

end
