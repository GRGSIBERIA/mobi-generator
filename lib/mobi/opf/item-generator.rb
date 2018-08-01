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

            # @return [ItemContainer] index.html
            attr_reader :index

            # @return [ItemContainer] cover.jpg
            attr_reader :cover

            # @return [ItemContainer] toc.ncx
            attr_reader :toc

            def initialize(pathes)
                @all = []
                @items = []
                @directories = []

                # toc.ncxをここで付加させておく
                pathes << "toc.ncx"

                for path in pathes 
                    item = ItemContainer.new(path)
                    unless item.is_dir? then
                        path = item.path.downcase
                        if path.include?("index.htm") or path.include?("index.html") then 
                            @index = item
                            @items << item
                        elsif path.include?("cover.jpg") or path.include?("cover.jpeg") then 
                            @cover = item 
                        elsif path.include?("toc.ncx") then 
                            @toc = item 
                            @items << item
                        else 
                            @items << item 
                        end
                    else 
                        @directories << item 
                    end
                    @all = item 
                end
            end
        end
    end
end