require "./lib/mobi"

class RubyParserTest < Minitest::Test
    def test_run
        assert_equal true, TeXMath.convert(" a^2 ", from: :tex, to: :mathml).include?("math")
    end

    def test_inline
        string = "{$ a^2 $}"
        assert_equal string.scan(/\{\$(.*)\$\}/)[0][0], " a^2 "
        assert_equal true, Mobi::Parser::MathML.parse(string).include?("inline")
    end

    def test_block
        string = "{{$ a^2 $}}"
        assert_equal string.scan(/\{\{\$(.*)\$\}\}/)[0][0], " a^2 "
        assert_equal true, Mobi::Parser::MathML.parse(string).include?("block")
    end

    def test_just_confuse
        string = "{{$ a^2 = b^2 $}} こんにちは {$ i_{in} $}"
        assert_equal true, Mobi::Parser::MathML.parse(string).include?("block")
        assert_equal true, Mobi::Parser::MathML.parse(string).include?("inline")
    end
end