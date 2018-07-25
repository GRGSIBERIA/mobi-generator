#-*- encoding: utf-8

class ItemNodeTest < Minitest::Test
    include Mobi::OPF

    def setup
        @node = ItemNode.new("./test.html")
        @dir = ItemNode.new("/img")
        @dired = ItemNode.new("./img/hoge.jpg")
        @root = ItemNode.new("./")
    end

    def test_ext
        assert_equal @node.ext, ".html"
        assert_equal @dir.ext, ""
        assert_equal @dired.ext, ".jpg"
        assert_equal @root.ext, ""
    end
    
    def test_is_dir
        assert_equal @node.is_dir?, false
        assert_equal @dir.is_dir?, true
        assert_equal @dired.is_dir?, false
        assert_equal @root.is_dir?, true
    end
end