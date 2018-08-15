#-*- encoding: utf-8

class OPFGeneratorTest < Minitest::Test
    include Mobi::OPF

    # @param [Hash] data 必要なデータ
    # @option data [String] :title タイトル, required
    # @option data [String, Array<String>] :creator 著者もしくは連名著者, required
    # @option data [String] :description 概要, required
    # @option data [String, Array<String>, NilClass] :contributor 貢献者
    # @option data [Boolean] :is_text 
    # @option data [Array<String>] :pathes ファイルのパス
    def setup
        @data = {
            title: "title",
            creator: ["testA", "testB", "testC"],
            description: "こんにちは",
            contributor: "test",
            is_text: true,
            pathes: [
                "hoge.html"
            ]
        }
        @n = OPFGenerator.new(@data)
    end

    def test_new
        puts @n.outxml
    end

    def test_hoge
        
    end
end