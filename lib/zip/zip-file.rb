#-*- encoding: utf-8
require "stringio"

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

    def set_stream(data)
        unless data.nil? then
            @stream.close
            @stream = StringIO.new(data)
        end
    end
end