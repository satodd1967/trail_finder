
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

#This works and pulls all the cities from the list
    # puts new_doc["records"].map {|arrays| arrays["fields"]["city"]}.first

#needs to be able to take in a city and return lat and lon
class Coordinates
    
    attr_accessor :lat, :lon

    def initialize
    end

    def api_call
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        data = Nokogiri::HTML(open(url))
        doc = JSON.parse(doc)
    end

    def get_lat_lon
        city = "Moab"
        state = "Utah"
        puts city
    end

end


