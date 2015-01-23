### Additional maintance tests ###
## These are run manually

using Base.Test


## lint
using Lint

lintpkg("Bootstrap")
#@test isempty(lintpkg( "Bootstrap", returnMsgs = true))


## doc test
using Lexicon
using Bootstrap

dt = doctest(Bootstrap)

@test length(failed(dt)) == 0


## type check
#using TypeCheck
#using Bootstrap

#checkreturntypes(Bootstrap)
#checklooptypes(Bootstrap)
#checkmethodcalls(Bootstrap)
