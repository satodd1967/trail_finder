require "nokogiri"
require "open-uri"
require "json"
require "pry"
    
 #This works to pull the individual trail confirms all data is available and working.  Returns the names of all trailse by parameters   
    # lat = 33.124
    # lon = -117.080
    # distance = 5
    # api_call = "https://www.mtbproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{distance}&key=200752494-3cc116808ab25b0826c7c50c3d42c825"
    # doc = Nokogiri::HTML(open(api_call))
    # new_doc = JSON.parse(doc)
    # puts new_doc["trails"].map {|trails| trails["name"]}

class Get_Trails


end   