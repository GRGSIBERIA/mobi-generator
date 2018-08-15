#-*- encoding: utf-8

class OPFFileTest < Minitest::Test
    include Mobi::File

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
        @n = OPFFile.new(@data)
    end

    def test_new
        puts @n.out_file("./test.xml")
    end
end