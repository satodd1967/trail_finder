
class TrailFinder::Trails

    attr_accessor :id, :name, :type, :summary, :difficulty, :stars, :starVotes, :location, :url, :imgSqSmall, :imgSmall, :imgSmallMed, :imgMedium, :length, :ascent, :descent, :high, :low, :longitude, :latitude, :conditionStatus, :conditionDetails, :conditionDate
   
    @@all = []

    #takes in a hash from the scraper class and then initializes each trail into an individual trail instance and pushes those trails into the @@all class variable
    def initialize(trail_list)
      trail_list.each {|key, value| self.send(("#{key}="), value)}
      @@all << self
    end

    #reader for the @@all class variable
    def self.all
        @@all
    end

    #class method that deletes all trails from the @@al class variable array. This is necessary on each initialize as the trails can only be pulled one city at a time
    def self.destroy
        @@all.clear
    end

end

