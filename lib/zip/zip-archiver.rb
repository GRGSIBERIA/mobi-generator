require 'zip'
require 'base64'
require 'stringio'

class NotMatchArraySizeError < Exception; end 

# 与えられたデータをZIPに圧縮する
class ZipArchiver
    attr_reader :archive

    def compress(files)
        Zip::OutputStream.write_buffer do |zos|
            for file in files 
                zos.put_next_entry(file.path)
                zos.write file.stream
            end
            zos.close_buffer
        end
    end

    # StringIOに圧縮されたファイルを突っ込む
    def initialize(files)
        out = compress(files)
        out.rewind
        @archive = out.read     # archiveには圧縮済みの文字列が入っている
    end

    def strict_encode64
        Base64.strict_encode64(@archive)
    end
end