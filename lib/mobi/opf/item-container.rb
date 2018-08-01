#-*- encoding: utf-8
require 'rdiscount'

module Mobi
    module OPF
        #
        # Itemコンテナ
        # NodeBaseは継承しない
        #
        class ItemContainer
            include Mobi::Parser

            # @return [String] ファイルのパス
            attr_reader :path

            # @return [String] id属性, ディレクトリを"_"に置き換えたbasename
            attr_reader :id

            # @return [String] ファイルの拡張子
            attr_reader :ext

            # @return [String] mime-type
            attr_reader :media_type

            # アイテム用のノード
            # @param filepath [String] ZIPファイル上のパス
            def initialize(filepath)
                @path = filepath
                @ext = File.extname(filepath)
                @basename = File.basename(filepath)
                @id = File.basename(filepath.gsub(/[\/|\\|\.]/, "_"))

                # この段階ですべて変換が済んでいると仮定する
                case @ext.downcase
                when ".jpg", ".jpeg"
                    @media_type = "image/jpeg"
                when ".png"
                    @media_type = "image/png"
                when ".htm", ".html", ".txt"
                    @media_type = "text/x-oeb1-document"
                when ".css"
                    @media_type = "text/css"
                end
            end

            # @return [Boolean] ディレクトリかどうか
            def is_dir?
                # /.bashrc のようなケースはディレクトリではない
                # /img のようなケースは拡張子がないのでディレクトリと判断する
                return (@basename != "" and @ext == "")
            end

            # itemノードを生成する
            # @param manifest [Mobi::OPF::ManifestNode] マニフェストノード
            # @return [Mobi::OPF::NodeBase] item要素
            def generate_item(manifest)
                if manifest.name != "manifest" then
                    throw DontMatchParentError
                end

                return NodeBase.new(manifest, "item", nil, {
                    "href" => @path,
                    "id" => @id,
                    "media_type" => @media_type
                })
            end

            # itemrefノードを生成する
            # @param spine [Mobi::OPF::SpineNode] データ列ノード
            # @return [Mobi::OPF::NodeBase] itemref要素
            def generate_itemref(spine)
                if spine.name != "spine" then 
                    throw DontMatchParentError 
                end

                return NodeBase.new(spine, "itemref", nil, {
                    "idref" => @id
                })
            end
        end
    end
end