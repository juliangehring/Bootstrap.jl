module BootstrapDoc

using Bootstrap
using Lexicon

cd( joinpath(Pkg.dir("Bootstrap"), "doc") )

config = Config(md_permalink = false,
                md_subheader = :category,
                include_internal = false,
                metadata_order = Symbol[],
                mathjax = true)
save("api.md", Bootstrap, config);

#cd( Pkg.dir("Bootstrap") )
#run(`mkdocs gh-deploy --clean`)
#run(`ipython nbconvert --to markdown city.ipynb --quiet --output city --profile julia --NbConvertBase.language_info=julia`)

end
