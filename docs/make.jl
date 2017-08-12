using Documenter
using Bootstrap

makedocs(
    modules = [Bootstrap]
)

deploydocs(
    repo = "github.com/juliangehring/Bootstrap.jl.git",
    latest = "develop",
    julia  = "0.6",
    deps = Deps.pip("mkdocs", "python-markdown-math", "pygments", "mkdocs-material")
)
