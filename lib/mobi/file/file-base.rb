#-*- encoding: utf-8

module Mobi
    module File
        class FileBase
            def check_as_output(prefix, param)
                if @data[param].nil? then
                    return ""
                end

                if @data[param].is_a?(Array)
                    # 配列の場合は展開する
                    nodes = ""
                    for item in @data[param]
                        nodes += create_node(prefix + param.to_s, {}, item)
                    end
                    return nodes
                end

                return create_node(prefix + param.to_s, {}, @data[param])
            end

            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>, NilClass] :contributor 貢献者
            # @option data [Boolean] :is_text 
            # @option data [Array<String>] :pathes ファイルのパス
            def initialize(data)
                @data = data 
                @text = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"

                @items = []
                for path in @data[:pathes]
                    @items << ItemContainer.new(path)
                end
            end

            # @return [String] 文字列を出力する
            def out_text
                @text
            end

            def out_file(path)
                ::File.open(path, "w") do |f|
                    f.puts(@text)
                end
            end

            private
            # @param [String] node_name ノード名
            # @param [String] inner_text 内部のテキスト，ノードの可能性もあり
            # @param [Hash] attributes 属性値
            def create_node(node_name, attributes={}, inner_text=nil)
                attr_text = ""
                attributes.each {|k, v| attr_text += " #{k.to_s}=\"#{v.to_s}\""}
                
                if inner_text.nil? or inner_text == "" then
                    return "<#{node_name}#{attr_text} />\n"
                end
                "<#{node_name}#{attr_text}>#{inner_text}</#{node_name}>\n"
            end
        end
    end
end