module Test_readme_code

if VERSION >= v"0.4-"
    using Base.Markdown
else
    using Markdown
end

rm = readme("Bootstrap")

for content in rm.content
    if issubtype(typeof(content), Markdown.Code)
        code = split(content.code, '\n')
        for line in code
            ## skip empty lines or comments which cannot be parsed
            if !isempty(line) && !ismatch(r"^#", line)
                eval(parse(line))
            end
        end
    end
end

end
