#-*- encoding: utf-8

module 
    def parse_ruby(string)
        # {{漢字|振り仮名}} -> <ruby>漢字<rp>(</rp><rt>振り仮名</rt><rp>)</rp></ruby>
        string.gsub(/\{\{(\w+)\|(\w+)\}\}/) do |match|
            kana, ruby = match.gsub(/\{\{/, "").gsub(/\}\}/, "").split("|")
            "<ruby>#{kana}<rp>(</rp><rt>#{ruby}</rt><rp>)</rp></ruby>"
        end
    end
end