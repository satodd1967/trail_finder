class TrailFinder::Trail_Scrape

    #pulls trail data from the mtbproject api, parses that data into a usable hash and then pushes that hash to the Trails class to be initialized into individual trail instances
    def self.api_call(lat, lon, distance)
        url = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=#{ENV['MTB_KEY']}"
        response = Nokogiri::HTML(open(url))
        parse = JSON.parse(response)
        trail_data = parse["trails"]
        trail_data.each do |trails|
            TrailFinder::Trails.new(trails)
        end
    end
end
