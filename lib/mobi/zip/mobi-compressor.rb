#-*- encoding: utf-8

module Mobi
    module Zip
        # Mobiファイル自体を生成するためのクラス
        class MobiCompressor
            # @return [StringIO] ZIP化された文字列ストリーム
            attr_reader :zipped_stream

            # @param [Array<Hash>] pathとstreamの組
            def initialize(entries)
                @zipped_stream = Zip::OutputStream.write_buffer do |zos|
                    for entry in entries
                        zos.put_next_entry(entry[:path])
                        zos.write(entry[:stream])
                    end
                    zos.close_buffer
                end
            end
        end
    end
end