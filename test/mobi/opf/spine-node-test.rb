#-*- encoding: utf-8

class SpineNodeTest < Minitest::Test
    include Mobi::OPF

    def setup
        @p = PackageNode.new
        @items = [
            ItemContainer.new("./toc.html"),
            ItemContainer.new("./test1.jpg"),
            ItemContainer.new("./test3.jpg"),
            ItemContainer.new("./test2.jpg"),
            ItemContainer.new("./test4.jpg"),
            ItemContainer.new("./page1.html"),
            ItemContainer.new("./page3.html"),
            ItemContainer.new("./page2.html"),
            ItemContainer.new("./page4.html")
        ]

        # コミック扱い
        @comic = SpineNode.new(@p, @items, true)
        @novel = SpineNode.new(@p, @items, false)
    end
    
    def test_new
        assert_equal @comic.node.name, "spine"
        assert_equal @comic.toc.id, "__toc_html"
    end

    def test_comic
        data = [
            ItemContainer.new("./toc.html"),
            ItemContainer.new("./test1.jpg"),
            ItemContainer.new("./test2.jpg"),
            ItemContainer.new("./test3.jpg"),
            ItemContainer.new("./test4.jpg"),
        ]
        for i in 0...data.size
            assert_equal data[i].id, @comic.published[i].id
        end
    end

    def test_novel
        data = [
            ItemContainer.new("./toc.html"),
            ItemContainer.new("./page1.html"),
            ItemContainer.new("./page2.html"),
            ItemContainer.new("./page3.html"),
            ItemContainer.new("./page4.html"),
        ]
        for i in 0...data.size
            assert_equal data[i].id, @novel.published[i].id
        end
    end
end