#-*- encoding: utf-8
require "stringio"

module Mobi
    module Zip
        #
        # Zipファイルの対応
        #
        class ZipFile
            # @return [String] ファイルのパス
            attr_reader :path

            # @return [StringIO] 文字列化したバイナリ
            attr_reader :stream

            def initialize(path, stream)
                @path = path 
                @stream = stream
            end

            # 新しいデータを設定する
            # @param [String] string 文字列データ
            def set_stream(string)
                unless data.nil? then
                    @stream.close
                    @stream = StringIO.new(string)
                end
            end
        end
    end
end