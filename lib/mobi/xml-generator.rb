#-*- encoding: utf-8

class XmlGenerator
    def add_node(parent, element_name, text=nil, attrs=nil)
        elem = REXML::Element(element_name)

        unless text.nil? then
            elem.add_text(text)
        end

        unless attrs.nil? then 
            for name, value in attrs 
                elem.add_attribute(name.to_s.gsub("__", ":").gsub("_", "-"), value.to_s)
            end
        end

        parent.add_element(elem)
        elem
    end

    def enforce_convert_to_utf8(extname, stream)
        string = nil
        case extname
        when ".md", ".txt", ".text", ".html", ".htm", ".css"
            string = stream.string 
            encoding = NKF.guess(string)
            unless encoding == NKF::UTF8 then
                case encoding 
                when NKF::SJIS
                    string = NKF.nkf('-w -S')
                when NKF::JIS 
                    string = NKF.nkf('-w -J')
                when NKF::EUC
                    string = NKF.nkf('-w -E')
                end
            end
        end
        string
    end
end