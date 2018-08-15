#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # packageノード，OPFのルートノード
        #
        class PackageNode < Mobi::Node::NodeBase
            # packageノード，OPFのルートノード
            def initialize
                super(nil, "package", nil, {
                    "unique-identifier" => "uid"
                })
            end
        end
    end
end
