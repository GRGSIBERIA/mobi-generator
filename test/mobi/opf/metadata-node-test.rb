#-*- encoding: utf-8

class MetadataNodeTest < Minitest::Test
    include Mobi::OPF

    def setup
        @p = PackageNode.new
        @n = MetadataNode.new(@p, {
            title: "タイトル",
            creator: ["著者1", "著者2"],
            contributor: ["協力者1", "協力者2"],
            description: "概要"
        })
    end
    
    def test_new
        assert_equal @n.node.name, "metadata"
        assert_equal @n.node.children[0].name, "dc-metadata"
        assert_equal @n.node.children[1].name, "x-metadata"
        
        assert_equal @n.node.children[0].children[0].name, "title"
        assert_equal @n.node.children[1].children[0].name, "output"
        assert_equal @n.node.children[1].children[1].name, "EmbeddedCover"
    end
end