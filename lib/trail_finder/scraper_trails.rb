#pulls data from teh MTB project api and stores it in an instance variable to be used for rider output
class TrailFinder::Trail_Scrape

    attr_accessor :lat, :lon, :distance, :data

    #initilizes a new instance of the class with lat, lon and distance variables hits the api call and stores the data in the @data instance variable
    def initialize(lat, lon, distance)
        @lat = lat
        @lon = lon
        @distance = distance
        @data = {}
        self.api_call
    end
    
    #pulls the data from the api and then json parses it into a usable hash and then stores it in the @doc instance variable
    def api_call
        api_call = "https://www.mtbproject.com/data/get-trails?lat=#{@lat}&lon=#{@lon}&maxDistance=#{@distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
        data = Nokogiri::HTML(open(api_call))
        @data = JSON.parse(data)
    end

end
