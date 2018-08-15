#-*- encoding: utf-8

class NodeBaseTest < Minitest::Test
    include Mobi::Node

    def test_new
        n = NodeBase.new(nil, "package")
        assert_equal n.node.name, "package"
    end

    def test_text
        n = NodeBase.new(nil, "package", "text")
        assert_equal n.node.get_text, "text"
    end

    def test_attributes
        n = NodeBase.new(nil, "package", "text", {
            "a" => "yamada",
            "b" => "ueda"
        })
        assert_equal n.node.get_text, "text"
        assert_equal n.node.attribute("a").to_s, "yamada"
        assert_equal n.node.attribute("b").to_s, "ueda"
    end
end