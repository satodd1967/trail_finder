
#pulls data from the public.opendatasoft.com api for the largest U.S. cities and thier lat/lon and saves them in the class variable @@doc
class TrailFinder::City_Scrape

    #stores the parsed hash of city data
    @@doc = {}

    #initializes a new instance of the scraper and loads the @@doc class variable with a json parsed hash of the city data
    def initialize
        self.api_call
    end
    
    #pulls data from the opendatasoft.com api and then uses JSON parse to convert it to a usable hash.  Stores that hash in the @@doc class variable.
    def api_call
        @@doc = {}
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        data = Nokogiri::HTML(open(url))
        @@doc =  JSON.parse(data)
    end

    #makes the @@doc class variable readable
    def self.doc
        @@doc
    end
end