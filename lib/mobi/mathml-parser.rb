require 'texmath-ruby'

module MathML 
    def clean_as_convert(match, pre, suf)
        clean = match.gsub(pre).gsub(suf)
        TeXMath.convert(clean, from: :tex, to: :mathml)
    end

    def parse(string)
        inline = string.gsub(/\{\{\$(\w*)\}\}/) do |match|
            clean_as_convert(match, "{{$", "}}")
        end

        display = inline.gsub(/\{\{\$\$(\w*)\}\}/) do |match|
            clean_as_convert(match, "{{$$, }}")
        end
    end
end