#-*- encoding: utf-8
require 'rexml/document'
require 'date'

#
# OPFファイルのジェネレータ
#
class OpfGenerator
    def insert_element(name, data, toc=false, &block)
        element = REXML::Element(name)
        if toc then 
            element.add_attribute("toc", "toc")
        end
        block.call(element, data)
        @doc.add_element(element)
    end

    def text_node(element_name, text)
        elem = REXML::Element(element_name)
        elem.add_text(text)
        elem
    end

    def attr_node(element_name, attrs)
        elem = REXML::Element(element_name)
        for name, value in attrs 
            elem.add_attribute(name.to_s.gsub("_", "-"), value.to_s)
        end
        elem
    end

    def add_metadeta(data)
        insert_element("metadata", data, false) do |element, data|
            dcmeta = REXML::Element("dc-metadata")
            dcmeta.add_element(text_node("dc:Title", data[:title]))
            dcmeta.add_element(text_node("dc:Language", "en-us"))
            dcmeta.add_element(text_node("dc:Creator", data[:creator]))
            dcmeta.add_element(text_node("dc:Publisher", data[:publisher]))
            dcmeta.add_element(text_node("dc:Date", Date.today.strftime("%d/%m/%Y")))
            dcmeta.add_element(text_node("dc:Description", data[:description]))
            element.add_element(dcmeta)

            x_meta = REXML::Element("x-metadata")
            x_meta.add_element(attr_node("output", {
                encoding: "utf-8", 
                content_type: "text/xoeb1-document"}))
            x_meta.add_element(text_node("EmbeddedCover", "cover.jpg"))
        end
    end

    def add_manifest(data)
        insert_element("manifest", data, false) do |data|

        end
    end

    def add_spine(data)
        insert_element("spine", data, true) do |data|

        end
    end

    def add_tours(data)
        insert_element("tours", data, false) do |data|

        end
    end

    def add_guide(data)
        insert_element("guide", data, false) do |data|

        end
    end

    # OPFファイルの作成
    # @param [Hash] data ファイルの作成に必要なデータ一式
    # :title
    # :creator
    # :publisher
    # :description
    # :files
    def initialize(data)
        @doc = REXML::Document.new
        @doc << REXML::XMLDecl.new('1.0', 'UTF-8')

        package = REXML::Element.new('package')
        package.add_attribute("unique-identifier", "uid")
        @doc.add_element(package)

        add_metadeta(data)
        add_manifest(data)
        add_spine(data)
        add_tours(data)
        add_guide(data)

    end
end