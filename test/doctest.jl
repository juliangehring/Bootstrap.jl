module Test_doctest

## doctest
using Lexicon
using Docile.Interface
using Bootstrap
using Base.Test

@test isdocumented(Bootstrap)

dt = doctest(Bootstrap);
@test length(failed(dt)) == 0

end
