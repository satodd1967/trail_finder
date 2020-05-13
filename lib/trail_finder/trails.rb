    
#needs to take in lat and lon and miles based on user input and get back trails
class TrailFinder::Get_Trails

    attr_accessor :lat, :lon, :distance

    def initialize(lat, lon, distance = 2)
        @lat = lat
        @lon = lon
        @distance = distance
        # @trail_data = {}
        @trail_data = TrailFinder::Trail_Scrape.new(lat, lon, distance).data
        # self.api_call
    end

    def get_trail_list
        trails = @trail_data["trails"].map {|trails| trails}
            output = trails.select do |trail|
            puts " "
            puts "//// #{trail["name"]} ////"
            puts "Location: #{trail["location"]}"
            puts "Difficulty: #{trail["difficulty"]}"
            puts "Star Rating: #{trail["stars"]}"
            puts "Length in Miles: #{trail["length"]}"
            puts "Ascent in Feet: #{trail["ascent"]}"
            puts "Descent in Feet: #{trail["descent"]}"
            puts "Summary: #{trail["summary"]}"
            puts "URL: #{trail["url"]}"
        end
        puts " "
        puts "Found #{trails.count} trails!"
        puts output
    end
end

# #  This works to pull the individual trail confirms all data is available and working.  Returns the names of all trailse by parameters   
#     lat = 33.124
#     lon = -117.080
#     distance = 5
#     api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
#     doc = Nokogiri::HTML(open(api_call))
#     new_doc = JSON.parse(doc)
#     trails = new_doc["trails"].map {|trails| trails}
#     output = trails.each do |trail|
#         puts " "
#         puts "//// #{trail["name"]} ////"
#         puts "Location: #{trail["location"]}"
#         puts "Difficulty: #{trail["difficulty"]}"
#         puts "Star Rating: #{trail["stars"]}"
#         puts "Length in Miles: #{trail["length"]}"
#         puts "Ascent in Feet: #{trail["ascent"]}"
#         puts "Descent in Feet: #{trail["descent"]}"
#         puts "Summary: #{trail["summary"]}"
#         puts "URL: #{trail["url"]}"
#     end