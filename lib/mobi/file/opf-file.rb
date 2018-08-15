module Mobi
    module File
        class OPFFile
            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>, NilClass] :contributor 貢献者
            # @option data [Boolean] :is_text 
            # @option data [Array<String>] :pathes ファイルのパス
            def initialize(data)
                
            end
        end
    end
end
