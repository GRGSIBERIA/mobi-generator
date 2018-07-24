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

                @items = expand_items(data)
            end

            private
            def expand_items(data)
                items = []
                for item in data[:items]
                    node = ItemNode.new(item[:filepath])
                    unless node.is_dir? then
                        items << node
                        node.generate_node(self)    # ディレクトリ以外はitem要素として追加し続ける
                    end
                end
                return items
            end
        end 
    end
end