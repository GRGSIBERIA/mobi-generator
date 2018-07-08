#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # Metadataノード
        #
        class MetadataNode < NodeBase
            # Metadataノード
            # @param [PackageNode] 親ノード
            # @param [Hash] data 必要なデータ
            # @option data [String] :title
            # @option data [String] :creator
            # @option data [String] :description
            def initialize(package, data)
                super("metadata", nil, {
                    "xmlns:dc" => "http://purl.org/dc/elements/1.1/"
                })

                # dcmeta
                @dcmeta = NodeBase.new(self, "dc-metadata")
                NodeBase.new(@dcmeta, "dc:Title", data[:title])
                NodeBase.new(@dcmeta, "dc:Language", "en-us")
                NodeBase.new(@dcmeta, "dc:Creator", data[:creator])
                NodeBase.new(@dcmeta, "dc:Description", data[:description])
                NodeBase.new(@dcmeta, "dc:Date", Date.today.strftime("%d/%m/%Y"))
                
                # xmeta
                @xmeta = NodeBase.new(self, "x-metadata")
                NodeBase.new(@xmeta, "output", nil {
                    "encoding" => "utf-8",
                    "content-type" => "text/x-oeb1-document"
                })
                NodeBase.new(@xmeta, "EmbeddedCover", "cover.jpg")
            end
        end
    end
end