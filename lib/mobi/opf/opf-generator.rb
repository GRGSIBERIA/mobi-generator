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
            # @option data [String, Array<String>, NilClass] :contributor 貢献者
            # @option data [Boolean] :is_text 書籍とコミックの区別, required
            # @option data [Array<String>] :pathes ファイルのパス, required
            def initialize(data)
                @package = PackageNode.new
                @metadata = MetadataNode.new(@package, data)
                
                @itemgen = ItemGenerator.new(data[:pathes])
                @manifest = ManifestNode.new(@package, @itemgen.manifest_items)
                @spine = SpineNode.new(@package, @itemgen.spine_items)
            end

            # @param [REXML::Document] XMLオブジェクトを出力
            def outxml
                return @package.outxml
            end
        end
    end
end