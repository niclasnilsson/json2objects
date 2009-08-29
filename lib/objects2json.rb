require 'json'

module Objects2Json
  
  def to_json(*a)
    result = "{ \"type\":\"#{self.class.name}\""
    json_attrs.each do |property|
      value =  json(property)
      result += ", #{value}" if value.length > 0
    end
    result += " }"
  end
  
  def json(property)
    value = send property
    return "" if value.nil?    
    return "\"#{property.to_s}\":[ #{json_array(value)} ]" if value.class == Array
    "\"#{property.to_s}\":#{value.inspect}"
  end
  
  def json_array(a)
    separator = ""
    a.map { |e| res = separator + e.to_json; separator = ", "; res }
  end

end



