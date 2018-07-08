#-*- encoding: utf-8
require "./lib/mobi/opf/node-base"
require "./lib/mobi/opf/package-node"

class PackageNodeTest < Minitest::Test
    include Mobi::OPF

    def test_new
        n = PackageNode.new
        assert_equal n.kind_of?(NodeBase), true
        assert_equal n.node.name, "package"
    end

    def test_derive
        n = PackageNode.new
    end
end