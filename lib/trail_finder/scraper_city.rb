class TrailFinder::City_Scrape

    #pulls city lat and lon data from opendatasoft.com, parses that data into a usable hash and then pushes that hash to the Cities class to be initialized into individual city instances
    def self.api_call
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        response = Nokogiri::HTML(open(url))
        parse = JSON.parse(response)
        city_data = parse["records"].map {|arrays| arrays["fields"]}
        city_data.each do |cities|
            TrailFinder::Cities.new(cities)
        end
    end

end