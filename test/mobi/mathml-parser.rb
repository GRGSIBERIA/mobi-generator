require "./lib/mobi/mathml-parser"

class RubyParserTest < Minitest::Test
    def test_run
        puts TeXMath.convert("a^2", from: :tex, to: :mathml)
    end
end