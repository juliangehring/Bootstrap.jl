using Documenter
using Bootstrap

makedocs(
    modules = [Bootstrap],
    format = :html,
    sitename = "Bootstrap.jl",
    doctest = true,
    checkdocs = :exports,
    linkcheck = true,
    html_disable_git = true, # disable source and edit links to github
    html_canonical = "https://juliangehring.github.io/Bootstrap.jl/stable/",
    pages = [
        "Home" => "index.md",
        "Library" => "library.md",
        "Changelog" => "NEWS.md",
        "License" => "LICENSE.md"
    ]
)

deploydocs(
    repo = "github.com/juliangehring/Bootstrap.jl.git",
    julia = "0.7",
    target = "build",
    latest = "develop",
    deps   = nothing,
    make   = nothing
)
