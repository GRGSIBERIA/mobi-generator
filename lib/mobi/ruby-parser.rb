#-*- encoding: utf-8

module RubyParser
    def parse(string)
        # {{漢字|振り仮名}} -> <ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby>
        string.gsub(/\{\{([ぁ-んァ-ヴ一-龠亜-煕]+)\|[ぁ-んァ-ヴ一-龠亜-煕]+\}\}/u) do |match|
            kana, ruby = match.gsub("{{", "").gsub("}}", "").split("|")
            "<ruby>#{kana}<rp>(</rp><rt>#{ruby}</rt><rp>)</rp></ruby>"
        end
    end

    module_function :parse
end