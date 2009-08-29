require 'lib/json2objects'
require 'json'
require 'facets'

class Person
  attr_accessor :id, :name, :married, :age, :weight, :addresses
  
end

class Address
  attr_accessor :street, :zip, :city
end


class SimpleSpec

  describe Json2Objects do
    it "should parse simple things" do
      json = <<EOT
      {
        "Type":"Person",
        "Id":620049,
        "Name":"John Smith",
        "Age":32,
        "Weight":73.5
      }
EOT
      objectifyer = Json2Objects.new

      person = objectifyer.create(json)
      
      person.class.should == Person
      person.id.should == 620049
      person.name.should == 'John Smith'
      person.age.should == 32
      person.weight.should == 73.5
    end

    it "should create nested objects in lists" do
      json = <<EOT
      {
        "Type":"Person",
        "Id":620049,
        "Name":"John Smith",
        "Married":true,
        "Age":32,
        "Weight":73.5,
        "Addresses":
        [
          {
            "Type":"Address",
            "Street":"Storgatan 3",
            "Zip":"311 01",
            "City":"Falkenberg"
          },
          {
            "Type":"Address",
            "Street":"Avenyn 1",
            "Zip":"411 72",
            "City":"Gothenburg"
          }
        ]
      }
EOT
    
      objectifyer = Json2Objects.new

      person = objectifyer.create(json)
      
      person.class.should == Person
      person.id.should == 620049
      person.name.should == 'John Smith'
      person.married.should == true
      person.age.should == 32
      person.weight.should == 73.5
      
      person.addresses.size.should == 2
      person.addresses.class.should == Array
      person.addresses[0].class.should == Address
      person.addresses[1].class.should == Address

      person.addresses[0].street.should == "Storgatan 3"
      person.addresses[1].street.should == "Avenyn 1"
      
      person.addresses[0].zip.should == "311 01"
      person.addresses[1].zip.should == "411 72"
      
      person.addresses[0].city.should == "Falkenberg"
      person.addresses[1].city.should == "Gothenburg"

    end
    
    
  end

end



