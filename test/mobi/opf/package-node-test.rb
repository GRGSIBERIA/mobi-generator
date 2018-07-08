#-*- encoding: utf-8
require "./lib/mobi/opf/node-base"
require "./lib/mobi/opf/package-node"

class PackageNodeTest < Minitest::Test
    def test_new
        n = PackageNode.new
        assert_equal n.kind_of?(NodeBase), true
    end

    def test_nodename
        n = PackageNode.new 
        assert_equal n.node.name, "package"
    end
end