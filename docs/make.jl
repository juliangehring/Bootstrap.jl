using Documenter
using Bootstrap

makedocs()

deploydocs(
    repo = "github.com/juliangehring/Bootstrap.jl.git",
    julia  = "0.4",
    deps = Deps.pip("mkdocs", "python-markdown-math", "pygments", "mkdocs-material")
)
