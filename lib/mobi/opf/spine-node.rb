#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # Spineノード
        # コンテンツの掲載順を定義する
        #
        class SpineNode < NodeBase
            # @return [Array<Mobi::OPF::ItemContainer>] ディレクトリを除いたファイル
            attr_reader :items
            
            # @return [*rray<Mobi::OPF::ItemContainer>] 掲載順のファイル
            attr_reader :published

            # @return [Array<Mobi::OPF::ItemContainer>] 目次ページ
            attr_reader :toc

            # @return [Boolean] コミック形式か否か
            def is_comic?
                is_comic
            end

            # Spineノード
            # コンテンツの掲載順を定義する
            # @param [PackageNode] package
            # @param [Array<Mobi::OPF::ItemContainer>] items 事前に作成されたデータ，item, itemref要素で使用する
            # @param [Boolean] コミック形式の真偽値
            def initialize(package, items, is_comic=false)
                super(package, "spine", nil, {"toc" => "ncx"})
                @items = []
                @published = []
                @toc = nil 
                @is_comic = is_comic

                expand_items(items) # @itemsと@tocに代入
                sort_items()        # @itemsをソートする
                record_items()      # @itemsから掲載するファイルを抽出する
            end

            private
            # HTMLのみを抽出する
            def expand_items(items)
                for item in items
                    if item.is_dir? then    # ディレクトリの場合は除外
                        next
                    end 

                    # 目次は先頭に置きたいので除外する
                    if item.id.include?("toc")
                        @toc = item 
                        next
                    end
                    @items << item
                end
            end

            def get_number_from_path(item)
                unless item.is_dir? then 
                    cut = item.path.split(".")[-2]
                    unless cut =~ /(\d+)$/ then 
                        throw DontHasNumberFromFileError.new 
                    else
                        # パスの中に.*d+-.*d+などの複数桁が複数存在しないという仮定
                        # 汎用性を持たせたい場合は修正する
                        return $1.to_i  
                    end
                else
                    # なぜかディレクトリが混じっているのでエラーを吐いておく
                    throw HasDirectoryFromFileError.new 
                end
            end

            def sort_items
                @items.sort!{|a,b| get_number_from_path(a) <=> get_number_from_path(b)}
            end

            def record_items
                # 書籍の形式によってspineに掲載するファイルを変更する
                published << @toc
                for item in @items 
                    if @is_comic then 
                        if item.ext == ".png" or item.ext == ".jpg" or item.ext == ".jpeg" then 
                            item.generate_itemref(self)
                            published << item 
                        end
                    else
                        if item.ext == ".htm" or item.ext == ".html" then 
                            item.generate_itemref(self)
                            published << item
                        end
                    end
                end
            end
        end 
    end
end