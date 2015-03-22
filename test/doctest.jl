module Test_doctest

## doctest
using Lexicon
using Bootstrap
using Base.Test

dt = doctest(Bootstrap);
@test length(failed(dt)) == 0

end
