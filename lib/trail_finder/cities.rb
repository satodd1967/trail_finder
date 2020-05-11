
require "nokogiri"
require "open-uri"
require "json"
require "pry"

# #All of the code necessary to pull down the city data
#     api_call = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
#     doc = Nokogiri::HTML(open(api_call))
#     new_doc = JSON.parse(doc)
    
#  #This works to get the list of available cities 
#     cities = new_doc["records"].map {|arrays| arrays["fields"]}
#     data  = cities.map {|cities| cities["city"]}
#     check = data.each {|cities| cities}.include?("New York")
#     puts check


# #This works and pulls all the cities from the list and then breaks them down to the coordinates for the single city
#     coordinates = []
#     city = "Denver"
#     state = "Colorado"
#     cities = new_doc["records"].map {|arrays| arrays["fields"]}
#     data  = cities.select {|cities| cities["city"] == city && cities["state"] == state}
#     data.each do |stuff|
#         coordinates << stuff["city"]
#         coordinates << stuff["state"]
#         coordinates << stuff["coordinates"]
#     end
#     puts coordinates[2].join(" ").split(" ")[0].to_f.round(3).to_s


#needs to be able to take in a city and return lat and lon to be used in the Get_Trails class
class Coordinates

    attr_accessor :city, :state
    
    #initializes a new instance of Coordinates with a city instance variable, a state variable and a coordinates instance variable set to an array.  The array will hold city, state and lattitude and longitude coordinates.
    def initialize(city = nil, state = nil)
        @city = city
        @state = state
        @coordinates = []
    end

    #pulls data from the MTB project api and then uses JSON parse to convert it to a usable hash.  Returns that hash.
    def api_call
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        data = Nokogiri::HTML(open(url))
        doc =  JSON.parse(data)
        doc
    end

    #parses city, state and lat/lon(as 1 string) data and pushes it into the coordinates array.
    def get_lat_lon
        cities = api_call["records"].map {|arrays| arrays["fields"]}
        selection = cities.select {|cities| cities["city"] == @city && cities["state"] == @state}
        selection.each do |items|
            @coordinates << items["city"]
            @coordinates << items["state"]
            @coordinates << items["coordinates"]
        end
    end

    #makes the instance variable @coordinates readable
    def read_coordinates
        @coordinates
    end

    #parses the lat from the lat/lon string stored in the instance variable @coordinates array
    def get_lat
        @coordinates[2].join(" ").split(" ")[0].to_f.round(3).to_s
    end
    
    #parses the lon from the lat/lon string stored in the instance variable @coordinates array
    def get_lon
        @coordinates[2].join(" ").split(" ")[1].to_f.round(3).to_s
    end

    def city_check(input)
        data = api_call["records"].map {|arrays| arrays["fields"]}
        cities = data.map {|cities| cities["city"]}
        check = cities.each {|cities| cities}.include?(input)
    end
    
    def state_check(input)
    end

end



