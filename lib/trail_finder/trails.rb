require "nokogiri"
require "open-uri"
require "json"
require "pry"
    
# #  This works to pull the individual trail confirms all data is available and working.  Returns the names of all trailse by parameters   
#     lat = 33.124
#     lon = -117.080
#     distance = 5
#     api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
#     doc = Nokogiri::HTML(open(api_call))
#     new_doc = JSON.parse(doc)
#     trails = new_doc["trails"].map {|trails| trails}
#     output = trails.each do |trail|
#                 puts "Name - #{trail["name"]}"
#                 puts " "
#                 puts "Summary - #{trail["summary"]}"
#                 puts " "
#                 puts " "
#     end

#needs to take in lat and lon and miles based on user input and get back trails
class Get_Trails

    attr_accessor :lat, :lon, :distance

    def initialize(lat, lon, distance = 100)
        @lat = lat
        @lon = lon
        @distance = distance
        @trail_data = {}
    end

    def api_call
        api_call = "https://www.mtbproject.com/data/get-trails?lat=#{@lat}&lon=#{@lon}&maxDistance=#{@distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
        data = Nokogiri::HTML(open(api_call))
        doc = JSON.parse(data)
        # puts new_doc["trails"].map {|trails| trails}.first
        doc
    end

    def get_trail_list
        trails = api_call["trails"].map {|trails| trails}
        output = trails.each do |trail|
            puts " "
            puts "Name: #{trail["name"]}"
            puts "Summary: #{trail["summary"]}"
            puts " "
            puts " "
        end
    end

end   



