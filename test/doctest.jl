## doctest
using Lexicon
using Bootstrap

dt = doctest(Bootstrap);
@test length(failed(dt)) == 0
