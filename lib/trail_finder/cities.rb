
require "nokogiri"
require "open-uri"
require "json"
require "pry"

#All of the code necessary to pull down the city data
    # api_call = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
    # doc = Nokogiri::HTML(open(api_call))
    # new_doc = JSON.parse(doc)

#Gets to the level needed.  Will need to itterate over this due to the fact that below records is an array
    # puts new_doc["records"][1]["fields"]["city"]

#This works and pulls all the cities from the list and then break them down to the coordinates for the single city
    # coordinates = []
    # city = "Marquette"
    # state = "Michigan"
    # cities = new_doc["records"].map {|arrays| arrays["fields"]}
    # data  = cities.select {|cities| cities["city"] == city && cities["state"] == state}
    # data.each do |stuff|
    #     coordinates << stuff["city"]
    #     coordinates << stuff["state"]
    #     coordinates << stuff["coordinates"]
    # end
    # puts coordinates


#needs to be able to take in a city and return lat and lon
class Coordinates

    attr_accessor :city, :state
    
    def initialize(city, state)
        @city = city
        @state = state
        @coordinates = []
    end

    def api_call
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        data = Nokogiri::HTML(open(url))
        doc =  JSON.parse(data)
        doc
    end

    def get_lat_lon
        cities = api_call["records"].map {|arrays| arrays["fields"]}
        selection = cities.select {|cities| cities["city"] == @city && cities["state"] == @state}
        selection.each do |items|
            @coordinates << items["city"]
            @coordinates << items["state"]
            @coordinates << items["coordinates"]
        end
    end

    def read_coordinates
        @coordinates
    end

end



