
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

