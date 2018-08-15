#-*- encoding: utf-8

module Mobi
    module File
        class OPFFile < FileBase
            # @param [Hash] data 必要なデータ
            # @option data [String] :title タイトル, required
            # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
            # @option data [String] :description 概要, required
            # @option data [String, Array<String>, NilClass] :contributor 貢献者
            # @option data [Boolean] :is_text 
            # @option data [Array<String>] :pathes ファイルのパス
            def initialize(data)
                
            end

            private
            def metadata
                dcmeta_nodes = ""
                dcmeta_nodes += check_as_output("dc:", :title)
                dcmeta_nodes += check_as_output("dc:", :creator)
                dcmeta_nodes += check_as_output("dc:", :description)
                dcmeta_nodes += check_as_output("dc:", :contributor)
                dcmeta_nodes += check_as_output("dc:", :date)

                xmeta_nodes = ""
                

                create_node("metadata", {
                    "xmlns:dc" => "http://purl.org/dc/elements/1.1/"
                }, dcmeta_nodes + xmeta_nodes)
            end
        end
    end
end
