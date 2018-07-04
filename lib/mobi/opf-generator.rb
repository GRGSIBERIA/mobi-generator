#-*- encoding: utf-8
require 'rexml/document'
require 'date'

#
# OPFファイルを作成するクラス
#
class OpfGenerator
    
    def add_attr(element, attrs)
        for name, value in attrs 
            element.add_attribute(name.to_s.gsub("_", "-"), value.to_s)
        end
    end

    def add_node(parent, element_name, text=nil, attrs=nil)
        elem = REXML::Element(element_name)

        unless text.nil? then
            elem.add_text(text)
        end

        unless attrs.nil? then 
            add_attr(elem, attrs)
        end

        parent.add_element(elem)
        elem
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

        
    end
end