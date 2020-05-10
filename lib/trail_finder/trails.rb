require "nokogiri"
require "open-uri"
require "json"
require "pry"

# doc = Nokogiri::HTML(open("https://www.mtbproject.com/data/get-trails?lat=33.124&lon=-117.080&maxDistance=10&key=200752494-3cc116808ab25b0826c7c50c3d42c825"))
# puts doc
    
    lat = 33.124
    lon = -117.080
    distance = 5
    api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
    doc = Nokogiri::HTML(open(api_call))
    new_doc = JSON.parse(doc)
    # puts new_doc["trails"].class
    puts new_doc["trails"].map {|trails| trails["name"]}
    
    # def get_trails
    #     lat = 33.124
    #     lon = -117.080
    #     distance = 5
    #     api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
    #     doc = Nokogiri::HTML(open(api_call))
    #     new_doc = JSON.parse(doc)
    #     puts new_doc
    # end

   