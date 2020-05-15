    
#needs to take in lat and lon and miles based on user input and get back trails
class TrailFinder::Get_Trails

    attr_accessor :lat, :lon, :distance, :trail_data

    #initializes a new instance of the class with lat, lon and optional distance data and loads the data from the trail scraper into the instance variable @trail_data
    def initialize(lat, lon, distance = 2)
        @lat = lat
        @lon = lon
        @distance = distance
        load_data = TrailFinder::Trail_Scrape.new(lat, lon, distance).data
        @trail_data = load_data
    end

    #transforms the data to get the appropriate list of trails and captures the trail count in the output
    def get_trail_list
        trails = @trail_data["trails"].map {|trails| trails}
           output = trails.each.with_index(1) do |trail, i|
            puts " "
            puts "#{i}, //// #{trail["name"]} ////"
            puts "  Location: #{trail["location"]}"
            puts "  Difficulty: #{trail["difficulty"]}"
            puts "  Star Rating: #{trail["stars"]}"
        end
        puts " "
        puts "-Found #{trails.count} trails!-"
    end

    #gets a trail count to be used for error handling in the det_details method int eh CLI class
    def trail_count
        trails = @trail_data["trails"].map {|trails| trails}
        trails.count
    end

    #gets details for a chosen trail and preps them for output
    def get_trail_details(choice)
        trails = @trail_data["trails"].map {|trails| trails}
        output = trails.select.with_index(1) do |trail, i|
            if i == choice.to_i
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
        end
    end

    # def get_trail_details(choice)
    #     trails = @trail_data["trails"].map {|trails| trails}
    #     output = trails.select.with_index(1) do |trail, i|
    #         if i == choice
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
    #         end
    #     puts output
    #     end
    # end

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