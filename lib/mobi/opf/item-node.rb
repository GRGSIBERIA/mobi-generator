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

            # @return [StringIO] ファイルコンテンツ
            attr_reader :contents
            
            # アイテム用のノード
            # @param filepath [String] ZIPファイル上のパス
            # @param content [StringIO] ファイルの実体
            def initialize(filepath, content)
                @path = filepath
                @ext = File.extname(filepath)
                @id = filepath.gsub(/[\/|\\]/, "_")
                @content = content

                case @ext.downcase
                when ".jpg", ".jpeg"
                    @media_type = "image/jpeg"
                when ".png"
                    @media_type = "image/png"
                when ".htm", ".html"
                    @media_type = "text/x-oeb1-document"
                when ".md"
                    @media_type = "text/x-oeb1-document"
                    
                end
            end

            # @return [Boolean] ディレクトリかどうか
            def is_dir?
                return @ext == "" and File.directory?(@path)
            end
        end
    end
end