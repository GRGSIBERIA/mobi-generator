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
end