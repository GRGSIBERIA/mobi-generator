#-*- encoding: utf-8
require "rexml/document"

#
# ノードのベースクラス
#
class NodeBase
    attr_reader :node

    # ノードのベースクラス
    # @param [String] node_name 要素名
    # @param [String] text 要素のテキスト
    # @param [Hash] attrs 要素の属性，String, [Any.to_s]で動作が保証される
    def initialize(node_name, text=nil, attrs=nil)
        @node = REXML::Element(node_name)
        unless text.nil? then
            @node.add_text(text)
        end

        unless attrs.nil? then 
            if attrs.kind_of?(Hash) then
                for key, value in attrs 
                    @node.add_attribute(key, value.to_s)
                end
            end
        end
    end
end