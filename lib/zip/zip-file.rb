#-*- encoding: utf-8
class ZipFile
    attr_reader :path, :stream

    def initialize(path, stream)
        @path = path 
        @stream = stream
    end
end