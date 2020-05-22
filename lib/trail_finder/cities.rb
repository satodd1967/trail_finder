class TrailFinder::Cities

    attr_accessor :city, :coordinates, :state, :rank, :growth_from_2000_to_2013, :population
   
    @@all = []
    @@featured_cities = []

    #initializes an instance of a city for each city pushed into the class from the scraper class based on the provided hash
    def initialize(city_list)
      city_list.each {|key, value| self.send(("#{key}="), value)}
      @@all << self
    end

    #reader for the @@all class variable
    def self.all
        @@all
    end

    #reader for the @@f_cities class variable.  This variable keeps track of the random cities chosen for featured cities
    def self.f_cities
        @@featured_cities
    end

    #pulls 5 random cities from the cities instances and then saves those cities to the @@f_cities class variable for later use in the details methods
    def self.featured_cities
        sample = @@all.sample(5)
        sample.each.with_index(1) do |cities, i|
            puts "#{i}. #{cities.city}, #{cities.state}"
        end
        sample.each do |cities|
            @@featured_cities << cities
        end
    end

    #provides the appropriate city instance to the get trails method in the cli.  This could be based on a featured city or a user entered city
    def self.get_city(city, state = nil, distance = nil)
        if city.to_i.between?(1, @@featured_cities.count)
            input = city.to_i - 1
            input_city = @@featured_cities[input]
        else 
            input_city = @@all.find {|cities| cities.city == city && cities.state = state}
        end
        input_city
    end

    #check a city and state combination against the @@all class variable.  If there is a valid combination it is returned otherwise it returns nil
    def self.state_check(city, state)
        @@all.find {|cities| cities.city == city && cities.state == state} 
    end

end



