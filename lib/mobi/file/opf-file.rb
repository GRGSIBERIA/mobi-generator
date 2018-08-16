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
            # @option data [Boolean] :is_text 
            # @option data [Array<String>] :pathes ファイルのパス
            def initialize(data)
                super(data)

                # Dateは強制的に挿入する
                @data[:date] = Date.today.strftime("%d/%m/%Y")

                @metadata = metadata()
                @manifest = manifest()
                @spine = spine()

                @text += create_node("package", {
                    "unique-identifier" => "uid"
                }, @metadata + @manifest + @spine)
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
                ""
            end
        end
    end
end
