#-*- encoding: utf-8
require "digest/sha2"
require "date"

module Mobi
    module OPF
        #
        # Metadataノード
        #
        class MetadataNode < NodeBase
            # Metadataノード
            # @param [PackageNode] 親ノード
            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>] :contributor
            def initialize(package, data)
                super(package, "metadata", nil, {
                    "xmlns:dc" => "http://purl.org/dc/elements/1.1/"
                })
                @publisher = "玖理刻文通株式会社"

                # dcmeta
                generate_dcmeta(data)
                generate_xmeta(data)
            end

            private
            # publisher + title + creatorから固有IDを生成する
            def generate_id(data)
                creator = data[:creator].is_a?(Array) ? data[:creator].join(",") : data[:creator]
                identifier = Digest::SHA512.hexdigest(@publisher + data[:title] + creator)
            end

            def generate_dcmeta(data)
                dcmeta = NodeBase.new(self, "dc-metadata")
                NodeBase.new(dcmeta, "dc:title", data[:title])
                NodeBase.new(dcmeta, "dc:language", "en-us")
                NodeBase.new(dcmeta, "dc:publisher", @publisher)
                generate_list(dcmeta, "dc:creator", data[:creator], true)
                generate_list(dcmeta, "dc:contributor", data[:contributor])
                NodeBase.new(dcmeta, "dc:description", data[:description])
                NodeBase.new(dcmeta, "dc:date", Date.today.strftime("%d/%m/%Y"))

                # IDの発行
                identifier = generate_id(data)
                NodeBase.new(dcmeta, "dc:identifier", identifier)
            end

            def generate_xmeta(data)
                xmeta = NodeBase.new(self, "x-metadata")
                NodeBase.new(xmeta, "output", nil, {
                    "encoding" => "utf-8",
                    "content-type" => "text/x-oeb1-document"
                })
                NodeBase.new(xmeta, "EmbeddedCover", "cover.jpg")
            end
        end
    end
end