using Documenter
using Bootstrap

makedocs(modules = [Bootstrap],
    sitename = "Bootstrap.jl",
    format = Documenter.HTML(disable_git = true,  # disable source and edit links to github
        canonical = "https://juliangehring.github.io/Bootstrap.jl/stable/"),
    doctest = true,
    checkdocs = :exports,
    linkcheck = true,
    pages = [
        "Home" => "index.md",
        "Library" => "library.md",
        "Changelog" => "NEWS.md",
        "License" => "LICENSE.md"
    ])

deploydocs(repo = "github.com/juliangehring/Bootstrap.jl.git")
