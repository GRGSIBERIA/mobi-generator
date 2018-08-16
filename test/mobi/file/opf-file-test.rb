#-*- encoding: utf-8

class OPFFileTest < Minitest::Test
    include Mobi::File

    def setup
        @data = {
            title: "title",
            creator: ["testA", "testB", "testC"],
            description: "こんにちは",
            contributor: "test",
            publisher: ["玖理刻", "角川"],
            is_text: true,
            pathes: [
                "hoge.html"
            ]
        }
        @n = OPFFile.new(@data)
    end

    def test_out_text
        assert_equal @n.out_text.include?("こんにちは"), true
        assert_equal @n.out_text.include?("testA"), true
    end

    def test_out_file
        @n.out_file("./test.xml")
        assert_equal File.exists?("./test.xml"), true
    end
end