#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # Manifestノード
        #
        class ManifestNode < Mobi::Node::NodeBase
            # @return [Array<Mobi::OPF::ItemContainer>] ItemContainerのインスタンスを返却する
            attr_reader :items

            # Manifestノード
            # @param [PackageNode] package
            # @param [Array<Mobi::OPF::ItemContainer>] items 事前に作成されたデータ，item, itemref要素で使用する
            def initialize(package, items)
                super(package, "manifest")
                @items = []

                expand_items(items)
            end

            private
            # 有効なデータに対してディレクトリかどうか精査し，追加可能なオブジェクトか判断する
            def expand_items(items)
                for item in items
                    unless item.is_dir? then
                        item.generate_item(self)    # ディレクトリ以外はitem要素として追加し続ける
                        @items << item
                    end
                end
            end
        end 
    end
end