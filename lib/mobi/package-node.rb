#-*- encoding: utf-8

#
# Packageノード
#
class PackageNode < NodeBase
    def initialize
        super("package", nil, {
            "unique-identifier" => "uid"
        })
    end
end