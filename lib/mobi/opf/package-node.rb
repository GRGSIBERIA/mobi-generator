#-*- encoding: utf-8

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