class TrailFinder::Trail_Scrape

    attr_accessor :lat, :lon, :distance, :data

    def initialize(lat, lon, distance)
        @lat = lat
        @lon = lon
        @distance = distance
        @data = {}
        self.api_call
    end
    
    def api_call
        api_call = "https://www.mtbproject.com/data/get-trails?lat=#{@lat}&lon=#{@lon}&maxDistance=#{@distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
        data = Nokogiri::HTML(open(api_call))
        @data = JSON.parse(data)
    end

end
