class TrailFinder::City_Scrape

    def self.api_call
        url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
        response = Nokogiri::HTML(open(url))
        parse = JSON.parse(response)
        data = parse["records"].map {|arrays| arrays["fields"]}
        data.each do |cities|
            TrailFinder::Cities.new(cities)
        end
    end

end