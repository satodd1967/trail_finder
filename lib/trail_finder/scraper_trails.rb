class TrailFinder::Trail_Scrape

    def self.api_call(lat, lon, distance)
        url = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
        response = Nokogiri::HTML(open(url))
        parse = JSON.parse(response)
        data = parse["trails"]
        data.each do |trails|
            TrailFinder::Trails.new(trails)
        end
    end
end

# lat = 33.124
# lon = -117.080
