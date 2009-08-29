$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'json'
require 'facets'

class Json2Objects
  VERSION = '0.0.3'

  def create(json)
    data = JSON.parse(json)
    create_object data
  end

  def to_json(o)

  end
  
  
  private
  
  def create_object(data)
    type_name = data['Type']
    o = eval "#{type_name}.new"
    
    data.each do |key, value|
      next if key == "Type"

      if value.class == Hash
        raise "Hashes not supported yet"
      elsif value.class == Array
        eval "o.#{key.snakecase} = create_array value"
      else
        eval "o.#{key.snakecase} = #{value.inspect}"  
      end
    end
    
    o
  end

  def create_array(data)
    arr = []
    data.each do |k|
      arr << create_object(k)
    end
    arr
  end
end
