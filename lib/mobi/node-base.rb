#-*- encoding: utf-8
require "rexml/document"

module Mobi
        module Node
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
                    @doc << REXML::XMLDecl.new('1.0', 'UTF-8')
                    @node = REXML::Element.new(node_name)
                    @doc.root.add_element(@node)
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

            # @return [String] 要素名
            def name
                return @node.name
            end

            protected
            def generate_list(adapter, name, list, required=false, has_id=false)
                # required=true list=nil の場合はエラーが発生する
                if list.nil? and required == false then 
                    return 
                elsif list.nil? and required == true 
                    raise RequiredAttributeError
                end

                if list.is_a?(Array)
                    id = 1
                    for item in list
                        hash = has_id ? {id: "\##{item.split(":")[-1]}"} : nil
                        NodeBase.new(adapter, "#{name}", item, hash)
                        id += 1
                    end
                else
                    hash = has_id ? {id: "\##{list.split(":")[-1]}"} : nil
                    NodeBase.new(adapter, "#{name}", list, hash)
                end
            end
        end
    end
end