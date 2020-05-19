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
        else 
            item = @@all.select {|cities| cities.city == city && cities.state = state}[0]
        end
        item
    end

end



