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

end
