#-*- encoding: utf-8
require "digest/sha2"
require "date"

module Mobi
    module OPF
        #
        # Metadataノード
        #
        class MetadataNode < Mobi::Node::NodeBase
            # Metadataノード
            # @param [PackageNode] 親ノード
            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>, NilClass] :contributor 貢献者
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
                dcmeta = Mobi::Node::NodeBase.new(self, "dc-metadata")
                Mobi::Node::NodeBase.new(dcmeta, "dc:title", data[:title])
                Mobi::Node::NodeBase.new(dcmeta, "dc:language", "en-us")
                Mobi::Node::NodeBase.new(dcmeta, "dc:publisher", @publisher)
                generate_list(dcmeta, "dc:creator", data[:creator], true)
                generate_list(dcmeta, "dc:contributor", data[:contributor])
                Mobi::Node::NodeBase.new(dcmeta, "dc:description", data[:description])
                Mobi::Node::NodeBase.new(dcmeta, "dc:date", Date.today.strftime("%d/%m/%Y"))

                # IDの発行
                identifier = generate_id(data)
                Mobi::Node::NodeBase.new(dcmeta, "dc:identifier", identifier)
            end

            def generate_xmeta(data)
                xmeta = Mobi::Node::NodeBase.new(self, "x-metadata")
                Mobi::Node::NodeBase.new(xmeta, "output", nil, {
                    "encoding" => "utf-8",
                    "content-type" => "text/x-oeb1-document"
                })
                Mobi::Node::NodeBase.new(xmeta, "EmbeddedCover", "cover.jpg")
            end
        end
    end
end