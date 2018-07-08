#-*- encoding: utf-8
require "./lib/mobi/node-base"

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