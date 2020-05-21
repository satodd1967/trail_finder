
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

    #Transforms trail data from tha @@all class variable into useful output for the CLI
    def self.get_trails
        @@all.select.with_index(1) do |trails, i|
            puts " "
            puts "#{i}. Name: //// #{trails.name} ////"
            puts "   Location: #{trails.location}"
            puts "   Difficulty: #{trails.difficulty}"
            puts "   Star Rating: #{trails.stars}"
            puts " " 
        end 
    end

    #Gets a trail from the @@al class variable and then transforms its data into useful output for the CLI
    def self.get_trail_details(choice)
        @@all.select.with_index(1) do |trails, i|
            if i == choice.to_i
                puts " "
                puts "//// #{trails.name} ////"
                puts "Location: #{trails.location}"
                puts "Difficulty: #{trails.difficulty}"
                puts "Star Rating: #{trails.stars}"
                puts "Length in Miles: #{trails.length}"
                puts "Ascent in Feet: #{trails.ascent}"
                puts "Descent in Feet: #{trails.descent}"
                puts "Summary: #{trails.summary}"
                puts "Condition: #{trails.conditionStatus}"
                puts "Condition Details: #{trails.conditionDetails}"
                puts "Condition Date: #{trails.conditionDate}"
                puts "URL: #{trails.url}"
                puts "***This trail will also open in your browser.  Return here to continue.***"
                puts " "
                sleep(1)
                system("open '#{trails.url}'")
            end
        end
    end

end

