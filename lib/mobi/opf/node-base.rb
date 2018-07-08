#-*- encoding: utf-8
require "rexml/document"

module Mobi
        module OPF
        #
        # ノードのベースクラス
        #
        class NodeBase
            attr_reader :node

            # ノードのベースクラス
            # @param [String] node_name 要素名
            # @param [String] text 要素のテキスト
            # @param [Hash] attrs 要素の属性，String, [Any.to_s]で動作が保証される
            # @param [NodeBase] parent 関連付けたい親ノード
            def initialize(node_name, text=nil, attrs=nil, parent=nil)
                @node = REXML::Element.new(node_name)

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

                unless parent.nil? then 
                    if parent.kind_of?(NodeBase) then 
                        parent.node.add_element(@node)
                    end
                end
            end
        end
    end
end