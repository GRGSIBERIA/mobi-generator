#-*- encoding: utf-8
require 'zip'
require 'base64'
require 'stringio'

module Mobi
    module Zip
        #
        # 与えられたデータをZIPに圧縮する
        #
        class ZipArchiver
            # @return [StringIO] 圧縮されたバイナリ
            attr_reader :archived

            def compress(files)
                Zip::OutputStream.write_buffer do |zos|
                    for file in files 
                        zos.put_next_entry(file.path)
                        zos.write file.stream
                    end
                    zos.close_buffer
                end
            end

            # ZipFileの配列を受け取って圧縮する
            # @param [Array<ZipFile>] files ZipFileのインスタンス配列
            def initialize(files)
                out = compress(files)
                out.rewind
                @archived = out.read     # archivedには圧縮済みの文字列が入っている
            end

            # @return [String] Base64に変換されたarchived
            def strict_encode64
                Base64.strict_encode64(@archived)
            end
        end
    end
end