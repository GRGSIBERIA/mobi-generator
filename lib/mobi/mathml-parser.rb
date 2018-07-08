require 'texmath'

# MathML用のモジュール
module MathML 
    def clean_as_convert(match, pre, suf)
        clean = match.gsub(pre).gsub(suf)
        TeXMath.convert(clean, from: :tex, to: :mathml)
    end

    # 対象の文字列の文字列群から特定の記号を探索し，該当部分をMathMLに変換する
    # @param [String] string MathMLに変換する対象の文字列，{{$～}}がインライン要素，{{$$～}}がブロック要素
    def parse(string)
        # ブロック要素の場合は特に変更しない
        block = string.gsub(/\{\{\$\$(\w*)\}\}/) do |match|
            clean_as_convert(match, "{{$$, }}")
        end

        # デフォルトではブロック要素で出力される
        inline = block.gsub(/\{\{\$(\w*)\}\}/) do |match|
            clean_as_convert(match, "{{$", "}}").gsub(%Q{<math display="block"}, %Q{<math display="inline"})
        end
    end

    module_function :parse
end