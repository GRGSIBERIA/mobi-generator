#-*- encoding: utf-8

module Mobi
    module OPF
        # パスの配列を読み取ってItemContainerの配列を生成するためのジェネレータクラス
        class ItemGenerator
            # @return [Array<ItemContainer>] manifestで有効なitemのみを返す
            attr_reader :manifest_items 

            # @return [Array<ItemContainer>] ディレクトリのみを返す
            attr_reader :directories

            # @return [Array<ItemContainer>] すべてのItemContainerを返す
            attr_reader :all

            # @return [ItemContainer] toc.html
            attr_reader :toc

            # @return [ItemContainer] cover.jpg
            attr_reader :cover

            # @return [ItemContainer] toc.ncx
            attr_reader :toc

            # @return [Array<ItemContainer>] spine用のファイルを列挙
            attr_reader :spine_items

            def initialize(pathes)
                @all = []
                @manifest_items = []
                @directories = []
                @spine_items = []

                # toc.ncxをここで付加させておく
                pathes << "toc.ncx"

                for path in pathes 
                    item = ItemContainer.new(path)
                    unless item.is_dir? then
                        path = item.path.downcase
                        if path.include?("toc.htm") or path.include?("toc.html") then 
                            @toc = item
                            @manifest_items << item
                            @spine_items << item
                        elsif path.include?("cover.jpg") or path.include?("cover.jpeg") then 
                            @cover = item 
                        elsif path.include?("toc.ncx") then 
                            @toc = item 
                            @manifest_items << item
                        elsif path.include?(".htm") or path.include?(".html") then 
                            @manifest_items << item 
                            @spine_items << item
                        else 
                            @manifest_items << item 
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