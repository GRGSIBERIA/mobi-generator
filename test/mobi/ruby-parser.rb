#-*- encoding: utf-8
require "minitest/autorun"
require "./lib/mobi/ruby-parser"

class RubyParserTest < Minitest::Test
    include RubyParser 

    def test_run
        str = "{{漢字|振り仮名}}"
        rep = str.gsub(/\{\{([ぁ-んァ-ヴ一-龠亜-煕]+)\|[ぁ-んァ-ヴ一-龠亜-煕]+\}\}/u) do |scan|
            kana, ruby = scan.gsub("{{", "").gsub("}}", "").split("|")
            "<ruby>#{kana}<rp>(</rp><rt>#{ruby}</rt><rp>)</rp></ruby>"
        end
        assert_equal rep, "<ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby>"
    end

    def test_parse_easy
        str = "{{漢字|振り仮名}}"
        rep = parse(str)
        assert_equal rep, "<ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby>"
    end

    def test_parse_multi
        str = "aaa {{漢字|振り仮名}} bbb {{漢字|振り仮名}} ccc {{漢字|振り仮名}}"
        rep = parse(str)
        assert_equal rep, "aaa <ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby> bbb <ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby> ccc <ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby>"
    end
end