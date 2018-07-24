#-*- encoding: utf-8
require 'rdiscount'

module Mobi
    module OPF
        #
        # Itemノード
        #
        class ItemNode
            include Mobi::Parser

            # @return [String] ファイルのパス
            attr_reader :path

            # @return [String] id属性
            attr_reader :id

            # @return [String] ファイルの拡張子
            attr_reader :ext

            # @return [String] mime-type
            attr_reader :media_type

            # アイテム用のノード
            # @param filepath [String] ZIPファイル上のパス
            def initialize(manifest, filepath)
                @path = filepath
                @ext = File.extname(filepath)
                @id = filepath.gsub(/[\/|\\]/, "_")

                case @ext.downcase
                when ".jpg", ".jpeg"
                    @media_type = "image/jpeg"
                when ".png"
                    @media_type = "image/png"
                when ".htm", ".html", ".md"
                    @media_type = "text/x-oeb1-document"
                when ".md"
                    @media_type = "text/x-oeb1-document"
                when ".css"
                    @media_type = "text/css"
                end
            end

            # @return [Boolean] ディレクトリかどうか
            def is_dir?
                return @ext == "" and File.directory?(@path)
            end

            # @param manifest [Mobi::OPF::ManifestNode] マニフェストノード
            def generate_node(manifest)
                if manifest.name != "manifest"
                    throw DontMatchParentError
                end

                return NodeBase.new(manifest, "item", {
                    "href" => @path,
                    "id" => @id,
                    "media_type" => @media_type
                })
            end
        end
    end
end