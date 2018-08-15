#-*- encoding: utf-8

class PackageNodeTest < Minitest::Test
    include Mobi::OPF

    def test_new
        n = PackageNode.new
        assert_equal n.kind_of?(Mobi::Node::NodeBase), true
        assert_equal n.node.name, "package"
    end

    def test_derive
        n = PackageNode.new
    end
end