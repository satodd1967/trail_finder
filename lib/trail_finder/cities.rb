class TrailFinder::Cities

    attr_accessor :city, :coordinates, :state, :rank, :growth_from_2000_to_2013, :population
   
    @@all = []
    @@f_cities = []

    def initialize(city_list)
      city_list.each {|key, value| self.send(("#{key}="), value)}
      @@all << self
    end

    def self.all
        @@all
    end

    def self.f_cities
        @@f_cities
    end

    def self.featured_cities
        sample = @@all.sample(5)
        sample.each.with_index(1) do |cities, i|
            puts "#{i}. #{cities.city}, #{cities.state}"
        end
        sample.each do |cities|
            @@f_cities << cities
        end
    end

    def self.get_city(city, state = nil, distance = nil)
        if city.to_i.between?(1, 5)
            input = city.to_i - 1
            item = @@f_cities[input]
            # lat = @@f_cities[input].coordinates[0]
            # lon = @@f_cities[input].coordinates[1]
        else 
            item = @@all.select {|cities| cities.city == city && cities.state = state}[0]
            # lat = city[0].coordinates[0]
            # lon = city[0].coordinates[1]
        end
        item
    end

end



####################################################################################################################
# #needs to be able to take in a city and return lat and lon to be used in the Get_Trails class
# require "pry"
# class TrailFinder::Coordinates

#     attr_accessor :city, :state
    
#     #initializes a new instance of Coordinates with a city instance variable, a state variable and a coordinates instance variable set to an array.  The array will hold city, state and lattitude and longitude coordinates.
#     def initialize(city = nil, state = nil)
#         @city = city
#         @state = state
#         @coordinates = []
#         self.get_lat_lon
#     end
    
#     #parses city, state and lat/lon(as 1 string) data and pushes it into the coordinates array.
#     def get_lat_lon
#         cities = TrailFinder::City_Scrape.doc["records"].map {|arrays| arrays["fields"]}
#         selection = cities.select {|cities| cities["city"] == @city && cities["state"] == @state}
#         selection.each do |items|
#             @coordinates << items["city"]
#             @coordinates << items["state"]
#             @coordinates << items["coordinates"]
#         end
#     end
    
#     #makes the instance variable @coordinates readable
#     def read_coordinates
#         @coordinates
#     end

#     #parses the lat from the lat/lon string stored in the instance variable @coordinates array
#     def get_lat
#         @coordinates[2].join(" ").split(" ")[0].to_f.round(3).to_s
#     end
    
#     #parses the lon from the lat/lon string stored in the instance variable @coordinates array
#     def get_lon
#         @coordinates[2].join(" ").split(" ")[1].to_f.round(3).to_s
#     end

#     #checks that the entered city is actually in the data set
#     def city_check(input)
#         data = TrailFinder::City_Scrape.doc["records"].map {|arrays| arrays["fields"]}
#         cities = data.map {|cities| cities["city"]}
#         check = cities.each {|cities| cities}.include?(input)
#     end
    
# end


