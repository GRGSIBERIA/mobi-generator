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
        
    end
end