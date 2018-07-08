#-*- encoding: utf-8

module Mobi
    module OPF
        #
        # Metadataノード
        #
        class MetadataNode < NodeBase
            def initialize(package)
                super("metadata", nil, {
                    "xmlns:dc" => "http://purl.org/dc/elements/1.1/"
                })

                # dcmeta
                @dcmeta = NodeBase.new("dc-metadata", nil, nil, self)
                
                # xmeta
                @xmeta = NodeBase.new("x-metadata", nil, nil, self)
            end
        end
    end
end