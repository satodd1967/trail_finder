
class TrailFinder::City_Scrape

    @@doc = {}

    def initialize
        self.api_call
    end
    
    #pulls data from the MTB project api and then uses JSON parse to convert it to a usable hash.  Returns that hash.
    def api_call
        @@doc = {}
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        data = Nokogiri::HTML(open(url))
        @@doc =  JSON.parse(data)
    end

    def self.doc
        @@doc
    end
end