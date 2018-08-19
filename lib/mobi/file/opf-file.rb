#-*- encoding: utf-8
require "date"

module Mobi
    module File
        class OPFFile < FileBase
            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>, NilClass] :contributor 貢献者
            # @option data [String, Array<String>] :publisher 出版社, required
            # @option data [Boolean] :is_text 
            # @option data [Array<String>] :pathes ソート済みのファイルのパス
            # @option data [Array<Hash>] :guide ガイド用のデータ, cover.html，toc.htmlが先頭にある前提
            # @option data[:guide] [String] :path ガイドに表示したいパス
            # @option data[:guide] [String] :title ガイドのタイトル
            def initialize(data)
                super(data)

                # Dateは強制的に挿入する
                @data[:date] = Date.today.strftime("%d/%m/%Y")

                @metadata = metadata()
                @manifest = manifest()
                @spine = spine()
                @tours = tours()
                @guide = guide()

                @text += create_node("package", {
                    "unique-identifier" => "uid"
                }, @metadata + @manifest + @spine + @tours + @guide)
            end

            private
            def metadata
                ##################################################
                # dcmetadataの作成
                dcmeta_nodes = ""
                dcmeta_nodes += check_as_output("dc:", :title)
                dcmeta_nodes += check_as_output("dc:", :creator)
                dcmeta_nodes += check_as_output("dc:", :description)
                dcmeta_nodes += check_as_output("dc:", :contributor)
                dcmeta_nodes += check_as_output("dc:", :date)
                
                dcmetadata = create_node("dc-metadata", {
                    "xmlns:dc" => "http://purl.org/metadata/dublin_core", 
                    "xmlns:oebpackage" => "http://openebook.org/namespaces/oeb-package/1.0/"
                }, dcmeta_nodes)

                ##################################################
                # x-metadataの作成
                xmeta_nodes = ""
                xmeta_nodes += create_node("output", {
                    "encoding" => "utf-8",
                    "content-type" => "text/x-oeb1-document"
                })
                xmeta_nodes += create_node("EmbeddedCover", {}, "cover.jpg")

                xmetadata = create_node("x-metadata", {}, xmeta_nodes)

                ##################################################
                # dc-metadataとx-metadataをmetadata内に挿入
                create_node("metadata", {
                    "xmlns:dc" => "http://purl.org/dc/elements/1.1/"
                }, dcmetadata + xmetadata)
            end

            def manifest
                items_text = ""
                for item in @items
                    items_text += create_node("item", {
                        "href" => item.path,
                        "id" => item.id,
                        "media-type" => item.media_type
                    })
                end
                create_node("manifest", {}, items_text)
            end

            def spine
                refs_text = ""
                for item in @items
                    
                    ##############################
                    # 表紙だけ例外にしたい
                    if not @data[:is_text] and item.data_type == :text and item.basename.include?("index") then 
                        refs_text += create_node("itemref", {
                            "idref" => item.id
                        })
                    ##############################
                    # テキストを表示したい
                    elsif @data[:is_text] and item.data_type == :text then
                        refs_text += create_node("itemref", {
                            "idref" => item.id
                        })
                    ##############################
                    # イラストを表示したい
                    elsif not @data[:is_text] and item.data_type == :picture then
                        refs_text += create_node("itemref", {
                            "idref" => item.id
                        })
                    end
                end
                create_node("spine", {
                    "toc" => "ncx"
                }, refs_text)
            end

            def tours
                create_node("tours", {}, "")
            end

            def guide
                guide_text = ""

                for guide in @data[:guide]
                    type = "text"
                    if is_text and guide[:path].include?("toc.html")
                        @items.each{|item| guide[:path].include?("toc.html") ? "toc" : type}
                    end
                    @items.each{|item| guide[:path].include?("cover.jpg") ? "cover" : type}

                    guide_text += create_node("referencce", {
                        "href" => guide[:path],
                        "title" => guide[:title],
                        "type" => type
                    })
                end
                create_node("guide", {}, guide_text)
            end
        end
    end
end
