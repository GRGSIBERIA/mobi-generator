require 'texmath'

module Mobi
    module Parser
        # MathML用のモジュール
        module MathML 
            # 文字列を整形してMathMLに変換する
            # @param [String] match 対象になる文字列，pre文字列sufの形式
            # @param [String] pre 整形対象の始まりの部分
            # @param [String] suf 整形対象の終わりの部分
            def clean_as_convert(match, pre, suf)
                clean = match.gsub(pre, "").gsub(suf, "")
                TeXMath.convert(clean, from: :tex, to: :mathml)
            end

            # 対象の文字列の文字列群から特定の記号を探索し，該当部分をMathMLに変換する
            # @param [String] string MathMLに変換する対象の文字列，{$～$}がインライン要素，{{$～$}}がブロック要素
            def parse(string)
                # ブロック要素を先に走査するのは，記法的にインライン要素が先にマッチするため
                block = string.gsub(/\{\{\$(.*)\$\}\}/) do |match|
                    clean_as_convert(match, "{{$", "$}}")
                end

                # インライン要素にヒットしたら変換する
                inline = block.gsub(/\{\$(.*)\$\}/) do |match|
                    clean_as_convert(match, "{$", "$}").gsub(%Q{<math display="block"}, %Q{<math display="inline"})
                end
            end

            module_function :parse, :clean_as_convert
        end
    end
end