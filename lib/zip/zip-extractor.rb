require "zip"
require "./procedures/zip/zip-file"

# ZIPファイルを展開してファイルごとのバイナリデータを取得する
class ZipExtractor
    attr_reader :files

    def initialize(inputFile)
        Zip::InputStream.open(inputFile) do |input|
            @files = []
            while (entry = input.get_next_entry)
                @files << ZipFile.new(entry.name, entry.get_input_stream.sysread)
            end
        end
    end
end