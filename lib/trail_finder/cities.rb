
require "nokogiri"
require "open-uri"
require "json"

api_call = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=1000-largest-us-cities-by-population-with-geographic-coordinates&q=&rows=1000&sort=-rank&facet=city&facet=state"
doc = Nokogiri::HTML(open(api_call))
new_doc = JSON.parse(doc)

#Gets to the level needed.  Will need to itterate over this due to the fact that below records is an array
# puts new_doc["records"][1]["fields"]["city"]

puts new_doc["records"].map {|arrays| arrays["fields"]["coordinates"]}.first



