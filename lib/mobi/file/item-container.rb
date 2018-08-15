#-*- encoding: utf-8
require 'rdiscount'

module Mobi
    module File
        #
        # Itemコンテナ
        # NodeBaseは継承しない
        #
        class ItemContainer
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
                @ext = File.extname(filepath).downcase
                @basename = File.basename(filepath)
                @id = File.basename(filepath.gsub(/[\/|\\|\.]/, "_"))

                # この段階ですべて変換が済んでいると仮定する
                case @ext
                when ".jpg", ".jpeg"
                    @media_type = "image/jpeg"
                when ".png"
                    @media_type = "image/png"
                when ".htm", ".html", ".txt"
                    @media_type = "text/x-oeb1-document"
                when ".css"
                    @media_type = "text/css"
                when ".ttf"
                    @media_type = "application/x-font-ttf"
                when ".ncx"
                    @media_type = "application/x-dtbncx+xml"
                end
            end

            # @return [Boolean] ディレクトリかどうか
            def is_dir?
                # /.bashrc のようなケースはディレクトリではない
                # /img のようなケースは拡張子がないのでディレクトリと判断する
                return (@basename != "" and @ext == "")
            end
        end
    end
end