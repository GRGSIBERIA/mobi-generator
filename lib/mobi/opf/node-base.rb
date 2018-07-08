#-*- encoding: utf-8
require "rexml/document"

module Mobi
        module OPF
        #
        # ノードのベースクラス
        #
        class NodeBase
            # @return [REXML::Element] ノードを返す
            attr_reader :node

            # @return [REXML::Element, nil] ルートノードを返す
            attr_reader :root

            # ノードのベースクラス
            # @param [NodeBase] parent 関連付けたい親ノード
            # @param [nil] parent 親ノードが存在しない場合はREXML::Documentを構築する
            # @param [String] node_name 要素名
            # @param [String] text 要素のテキスト
            # @param [Hash] attrs 要素の属性，String, [Any.to_s]で動作が保証される
            def initialize(parent, node_name, text=nil, attrs=nil)
                if parent.nil? then 
                    @doc = REXML::Document.new("<#{node_name}/>")
                    @node = @doc.root
                else
                    @node = REXML::Element.new(node_name)
                    if parent.kind_of?(NodeBase) then 
                        parent.node.add_element(@node)
                    end
                end

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
    end
end