#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # Manifestノード
        #
        class ManifestNode < NodeBase
            # Manifestノード
            # @param [PackageNode] package
            # @param [Hash] data
            # @option data [Hash] :items ZIP中に存在しているファイル関係
            def initialize(package, data)
                super(package, "manifest")

            end

            private
            def expand_items(data)
                for item in data[:items]
                    ItemNode.new(item[:filepath], item[:contents])
                end
            end
        end 
    end
end