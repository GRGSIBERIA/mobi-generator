#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # packageノード
        #
        class PackageNode < NodeBase
            # packageノード
            def initialize
                super("package", nil, {
                    "unique-identifier" => "uid"
                })
            end
        end
    end
end
