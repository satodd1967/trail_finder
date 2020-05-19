
class TrailFinder::Trails

    attr_accessor :id, :name, :type, :summary, :difficulty, :stars, :starVotes, :location, :url, :imgSqSmall, :imgSmall, :imgSmallMed, :imgMedium, :length, :ascent, :descent, :high, :low, :longitude, :latitude, :conditionStatus, :conditionDetails, :conditionDate
   
    @@all = []

    def initialize(trail_list)
      trail_list.each {|key, value| self.send(("#{key}="), value)}
      @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy
        @@all.clear
    end

end

####################################################################################################################
# require "pry"    
# #needs to take in lat and lon and miles based on user input and get back trails
# class TrailFinder::Get_Trails

#     attr_accessor :lat, :lon, :distance, :trail_data

#     @@list = []
    
#     #initializes a new instance of the class with lat, lon and optional distance data and loads the data from the trail scraper into the instance variable @trail_data
#     def initialize(lat, lon, distance = 2)
#         TrailFinder::Get_Trails.destroy
#         @lat = lat
#         @lon = lon
#         @distance = distance
#         @trail_data = TrailFinder::Trail_Scrape.new.api_call(lat, lon, distance)
#         @@list << self
#     end

#     #transforms the data to get the appropriate list of trails and captures the trail count in the output
#     def get_trail_list
#         @trail_data.select.with_index(1) do |trail, i|
#             puts " "
#             puts "#{i}, //// #{trail["name"]} ////"
#             puts "  Location: #{trail["location"]}"
#             puts "  Difficulty: #{trail["difficulty"]}"
#             puts "  Star Rating: #{trail["stars"]}"
#         end
#         puts " "
#         puts "-Found #{@trail_data.count} trails!-"
#     end

#     #gets a trail count to be used for error handling in the det_details method int eh CLI class
#     def trail_count
#         @trail_data.count
#     end

#     #gets details for a chosen trail and preps them for output
#     def get_trail_details(choice)
#         @trail_data.select.with_index(1) do |trail, i|
#             if i == choice.to_i
#                 puts " "
#                 puts "//// #{trail["name"]} ////"
#                 puts "Location: #{trail["location"]}"
#                 puts "Difficulty: #{trail["difficulty"]}"
#                 puts "Star Rating: #{trail["stars"]}"
#                 puts "Length in Miles: #{trail["length"]}"
#                 puts "Ascent in Feet: #{trail["ascent"]}"
#                 puts "Descent in Feet: #{trail["descent"]}"
#                 puts "Summary: #{trail["summary"]}"
#                 puts "Condition: #{trail["conditionStatus"]}"
#                 puts "Condition Details: #{trail["conditionDetails"]}"
#                 puts "Condition Date: #{trail["conditionDate"]}"
#                 puts "URL: #{trail["url"]}"
#             end
#         end
#     end

#     def self.list
#         @@list
#     end

#     def self.destroy
#         @@list.clear
#     end

# end

# Console Test Data  
# lat = 33.124
# lon = -117.080
# distance = 5