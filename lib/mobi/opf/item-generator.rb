#-*- encoding: utf-8

module Mobi
    module OPF
        # パスの配列を読み取ってItemContainerの配列を生成するためのジェネレータクラス
        class ItemGenerator
            # @return [Array<ItemContainer>] 有効なitemのみを返す
            attr_reader :items 

            # @return [Array<ItemContainer>] ディレクトリのみを返す
            attr_reader :directories

            # @return [Array<ItemContainer>] すべてのItemContainerを返す
            attr_reader :all

            def initialize(pathes)
                @all = []
                @items = []
                @directories = []
                for path in pathes 
                    item = ItemContainer.new(path)
                    unless item.is_dir? then
                        @items << item 
                    else 
                        @directories << item 
                    end
                    @all = item 
                end
            end
        end
    end
end