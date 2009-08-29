require File.dirname(__FILE__) + '/spec_helper.rb'

class Person
  include Objects2Json

  attr_accessor :id, :name, :married, :age, :weight, :addresses
  
  def json_attrs
    [:id, :name, :married, :age, :weight, :addresses]
  end
  
end

class Address
  include Objects2Json

  attr_accessor :street, :zip, :city
  
  def json_attrs
    [:street, :zip, :city]
  end

end




class Objects2JsonSpec

  describe "Objects2Json" do
    it "should deserialize simple objects" do
      person = Person.new
      person.id = 565656
      person.name = "John Smith"
      person.married = true
      person.age = 32
      person.weight = 67.5

      json = person.to_json
      
      expected = %q{{ "type":"Person", "id":565656, "name":"John Smith", "married":true, "age":32, "weight":67.5 }}
      expected = expected.strip
      json.should == expected
    end


    it "should deserialize complex objects" do
      person = Person.new
      person.id = 565656
      person.name = "John Smith"
      person.married = true
      person.age = 32
      person.weight = 67.5

      addresses = []

      address = Address.new
      address.street = "Storgatan 3"
      address.zip = "311 01"
      address.city = "Falkenberg"
      
      addresses << address
      
      address = Address.new
      address.street = "Avenyn 1"
      address.zip = "411 72"
      address.city = "Gothenburg"
      
      addresses << address
      person.addresses = addresses
      
      json = person.to_json
      
      expected = %q{{ "type":"Person", "id":565656, "name":"John Smith", "married":true, "age":32, "weight":67.5, "addresses":[ { "type":"Address", "street":"Storgatan 3", "zip":"311 01", "city":"Falkenberg" }, { "type":"Address", "street":"Avenyn 1", "zip":"411 72", "city":"Gothenburg" } ] }}
      
      json.should == expected
    end
    
      

  end
end

