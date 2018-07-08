#-*- encoding: utf-8
require "zip"

module Mobi
    #
    # ZIPファイルを展開し，ZipFileの配列を作成する
    #
    class ZipExtractor
        # @return [Array<ZipFile>] 展開されたZipFileの配列
        attr_reader :files

        # ZIPファイルを展開する
        # @param [StringIO] input_file 入力するZIPファイル
        # @param [IO] input_file 入力するZIPファイル
        def initialize(input_file)
            Zip::InputStream.open(input_file) do |input|
                @files = []
                while (entry = input.get_next_entry)
                    @files << ZipFile.new(entry.name, entry.get_input_stream.sysread)
                end
            end
        end
    end
end