using Documenter
using Bootstrap

makedocs()

custom_deps() = run(`pip install --user pygments mkdocs mkdocs-material`)

deploydocs(
    repo = "github.com/juliangehring/Bootstrap.jl.git",
    julia  = "0.4",
    deps = Deps.pip("mkdocs", "python-markdown-math", "pygments", "mkdocs-material")
)
