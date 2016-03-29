using Documenter
using Bootstrap

makedocs(modules = [Bootstrap])

custom_deps() = run(`pip install --user pygments mkdocs mkdocs-material`)

deploydocs(
    repo = "github.com/julian-gehring/Bootstrap.jl.git",
    julia  = "0.4"
)
