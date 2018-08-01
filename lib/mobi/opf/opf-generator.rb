#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # OPFファイルのジェネレータクラス
        #
        class OPFGenerator
            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>] :contributor
            # @option data [Array<String>] :pathes ファイルのパス
            def initialize(data)
                @package = Package.new
                @metadata = MetadataNode.new(@package, data)
                
                @itemgen = ItemGenerator.new(data[:pathes])
                @manifest = ManifestNode.new(@itemgen.items)
            end
        end
    end
end