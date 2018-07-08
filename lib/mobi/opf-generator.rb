#-*- encoding: utf-8
require 'rexml/document'
require 'date'
require 'stringio'
require 'rdiscount'
require 'nkf'

#
# OPFファイルを作成するクラス
#
class OpfGenerator < XmlGenerator
    private :package_node, :metadata_node, :manifest_node

    def package_node()
        package = add_node(@doc, "package", nil, {
            unique_identifier: "uid"
        })
    end

    def metadata_node(package)
        meta = add_node(package, "metadata", nil, {
            xmlns__dc: "http://purl.org/dc/elements/1.1/"
        })

        dcmeta = add_node(meta, "dc-metadata")
        add_node(dcmeta, :dc__Title, @data[:title])
        add_node(dcmeta, :dc__Language, "en-us")
        add_node(dcmeta, :dc__Creator, @data[:creator])
        add_node(dcmeta, :dc__Description, @data[:description])
        add_node(dcmeta, :dc__Date, Date.today.strftime("%d/%m/%Y"))

        xmeta = add_node(meta, "x-metadata")
        add_node(xmeta, "output", nil, {
            encoding: "utf-8",
            content_type: "text/x-oeb1-document"
        })
        add_node(xmeta, "EmbeddedCover", "cover.jpg")
    end

    def manifest_node(package)
        manifest = add_node(package, "manifest")

        for file in @data[:files]
            parts = {
                href: file.path,
                id: File.basename(file.path, ".*")
            }

            # 文字ファイルの場合はUTF8へ強制的に変換する
            extname = File.extname(file.path).downcase
            string = enforce_convert_to_utf8(extname, file.stream)

            case extname
            when ".jpg", ".jpeg"
                parts[:media_type] = "image/jpeg"
            when ".png"
                # png -> jpg
                # NOTICE:
                # 変換コードをここに書く
                parts[:media_type] = "image/jpeg"

            when ".md", ".txt", ".text"
                # markdown -> html
                markdown = RDiscount.new(string)
                html = markdown.to_html

                # LaTeXでRubyがマッチする可能性があるので，MathMLからレンダリングする．
                mathed = MathML.parse(html)
                unless mathed == html then 
                    parts[:properties] = "mathml"   # MathMLが存在するならproperties属性にmathmlを追加しなければならない
                end
                rubied = RubyParser.parse(mathed)   # {kana|furi}的な記法がLaTeXでは存在し得る

                file.set_stream(rubied)
                parts[:media_type] = "text/x-oeb1-document"

            when ".html", ".htm"
                file.set_stream(string)
                parts[:media_type] = "text/x-oeb1-document"

            when ".css"
                file.set_stream(string)
                parts[:media_type] = "text/x-oeb1-css"

            when ".ttf"
                parts[:media_type] = "application/x-font-ttf"
            end 

            # media_typeが存在しなければスルー
            unless parts[:media_type].nil?
                add_node(manifest, "item", nil, parts)
            end
        end
    end

    # OPFファイルの作成
    # @param [Hash] data ファイルの作成に必要なデータ一式
    # @option data [String] :title タイトル
    # @option data [String] :creator 作成者
    # @option data [String] :publisher 出版社
    # @option data [String] :description 書籍の概要
    # @option data [Array<ZipFile>] :files ファイルの配列
    def initialize(data)
        @data = data 
        @doc = REXML::Document.new
        @doc << REXML::XMLDecl.new('1.0', 'UTF-8')

        package = REXML::Element.new('package')
        package.add_attribute("unique-identifier", "uid")
        @doc.add_element(package)

        package = package_node()
        metadata_node(package)
        manifest_node(package)
    end

    # StringIOでXMLを出力
    # @return [StringIO] StringIOのXML
    def write_stringio
        xos = StnigIO.new 
        @doc.write(xos, indent=2)
        xos
    end

    # ファイルでXMLを出力
    # @param [String] 書き出すパス
    def write_file(path)
        File.open(path, "w") do |file|
            @doc.write(file, indent=2)
        end
    end
end