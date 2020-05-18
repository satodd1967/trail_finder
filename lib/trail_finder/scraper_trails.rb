class TrailFinder::Trail_Scrape

    def api_call(lat, lon, distance)
        lat = 33.124
        lon = -117.080
        distance = 2
        api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
            response = Nokogiri::HTML(open(api_call))
            parse = JSON.parse(response)
            data = parse["trails"].map {|trails| trails}
        end
end

# lat = 33.124
# lon = -117.080

#################################################################################################################
# #pulls data from teh MTB project api and stores it in an instance variable to be used for rider output
# class TrailFinder::Trail_Scrape

#     attr_accessor :lat, :lon, :distance, :data

#     def api_call (lat, lon, distance)
#         api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
#         response = Nokogiri::HTML(open(api_call))
#         parse = JSON.parse(response)
#         data = parse["trails"].map {|trails| trails}
#     end

# end
