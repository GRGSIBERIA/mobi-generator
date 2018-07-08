#-*- encoding: utf-8
require "./lib/mobi/package-node"

class PackageNodeTest < Minitest::Test
    def test_new
        n = PackageNode.new
    end
end