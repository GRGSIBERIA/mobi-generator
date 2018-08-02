#-*- encoding: utf-8

module Mobi
    module Zip
        # ZIPファイルを展開するクラス
        class ZipExtractor
            # @return [Array<Hash>] pathとstreamの組
            # @option return [String] :path パス
            # @option return [StringIO] :stream ファイルの文字列ストリーム
            attr_reader :entries

            # @param file [IO] ZIPファイル本体，IOクラスを継承
            def initialize(file)
                @entries = []

                Zip::InputStream.open(file) do |ios|
                    while (entry = ios.get_next_entry)
                        @entries << {path: entry.name, stream: entry.get_input_stream.sysread}
                    end
                    ios.close
                end
            end
        end
    end
end