#-*- encoding: utf-8

class ManifestNodeTest < Minitest::Test
    include Mobi::OPF

    def setup
        @p = PackageNode.new
        @items = [
            ItemContainer.new("./index.html"),
            ItemContainer.new("./test.jpg")
        ]
        @n = ManifestNode.new(@p, @items)
    end
    
    def test_new
        assert_equal @n.node.name, "manifest"
        
        assert_equal @n.node.children[0].name, "item"
        assert_equal @n.node.children[0].attribute("id").to_s, "__index_html"
        assert_equal @n.node.children[1].attribute("id").to_s, "__test_jpg"
    end
end