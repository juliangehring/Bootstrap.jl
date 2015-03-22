### Additional maintance tests ###
## These are run manually

using Base.Test


## lint
using Lint

lintpkg("Bootstrap")
@test isempty(lintpkg( "Bootstrap", returnMsgs = true))

## type check
using TypeCheck
using Bootstrap

checkreturntypes(Bootstrap)
checklooptypes(Bootstrap)
#checkmethodcalls(Bootstrap)
