#-*- encoding: utf-8
require 'rexml/document'
require 'date'

#
# OPFファイルを作成するクラス
#
class OpfGenerator
    
    def add_node(parent, element_name, text=nil, attrs=nil)
        elem = REXML::Element(element_name)

        unless text.nil? then
            elem.add_text(text)
        end

        unless attrs.nil? then 
            for name, value in attrs 
                elem.add_attribute(name.to_s.gsub("__", ":").gsub("_", "-"), value.to_s)
            end
        end

        parent.add_element(elem)
        elem
    end

    def package_node()
        package = add_node(@doc, "package", nil, {
            unique_identifier: "uid"
        })
    end

    def metadata_node(package)
        meta = add_node(package, "metadata")

        dcmeta = add_node(meta, "dc-metadata")
        add_node(dcmeta, "dc__Title", @data[:title])
        add_node(dcmeta, "dc__Language", "en-us")
        add_node(dcmeta, "dc__Creator", @data[:creator])
        add_node(dcmeta, "dc__Description", @data[:description])
        add_node(dcmeta, "dc__Date", Date.today.strftime("%d/%m/%Y"))

        xmeta = add_node(meta, "x-metadata")
        add_node(xmeta, "output", nil, {
            encoding: "utf-8",
            content_type: "text/x-oeb1-document"
        })
        add_node(xmeta, "EmbeddedCover", "cover.jpg")
    end

    # OPFファイルの作成
    # @param [Hash] data ファイルの作成に必要なデータ一式
    # @option data [Symbol] :title タイトル
    # @option data [Symbol] :creator 作成者
    # @option data [Symbol] :publisher 出版社
    # @option data [Symbol] :description 書籍の概要
    # @option data [Symbol] :files ファイルの配列
    def initialize(data)
        @data = data 
        @doc = REXML::Document.new
        @doc << REXML::XMLDecl.new('1.0', 'UTF-8')

        

        package = REXML::Element.new('package')
        package.add_attribute("unique-identifier", "uid")
        @doc.add_element(package)

        package = package_node()
        metadata_node(package)

    end
end