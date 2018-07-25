#-*- encoding: utf-8

class ItemContainerTest < Minitest::Test
    include Mobi::OPF

    def setup
        @node = ItemContainer.new("./test.html")
        @dir = ItemContainer.new("/img")
        @dired = ItemContainer.new("./img/hoge.jpg")
        @root = ItemContainer.new("./")
        @items = [@node, @dir, @dired, @root]

        @package = PackageNode.new
        @manifest = ManifestNode.new(@package, @items)
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

    def test_generate_item
        @node.generate_item(@manifest)
    end
end