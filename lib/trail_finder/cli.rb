class TrailFinder::CLI

    def initialize
        colors
    end

    def call
        puts "Loading..."
        TrailFinder::City_Scrape.api_call
        intro
        featured_cities
        controller_main
        over
    end

    def colors
        @red = "\u001b[31m"
        @green = "\u001b[32m"
        @yellow = "\u001b[33m"
        @blue = "\u001b[34m"
        @reset = "\u001b[0m"
    end

    # puts intro script to the rider
    def intro
        puts " "
        puts "#{@yellow}!!!! RIDE FAST CRASH LESS !!!!"
        puts "       Welcome Riders!#{@reset}"
        puts " "
        puts "Ride Fast Crash Less is a tool that allows you to input your city and get back all the best trails in your area."
        puts "Below is a list of featured cities.  You can either choose one of those by inputing the corresponding number or you can enter your local city."
        puts " "
    end

    def featured_cities
        TrailFinder::Cities.featured_cities
    end

    def where
        puts " "
        puts "#{@green}Where would you like to ride? Enter exit to quit.#{@reset}"
    end

    def where_now
        puts "#{@green}* Would you like to find more trails? *"
        puts "Enter a new city to search! Or enter Exit to hit the trails!#{@reset}"
    end

    def city_true(input)
        TrailFinder::Cities.all.map {|cities| cities.city}.include?(input)
    end

    def get_trails(city, state = nil, distance = nil)
        item = TrailFinder::Cities.get_city(city, state, distance)
        TrailFinder::Trails.destroy
        TrailFinder::Trail_Scrape.api_call(item.coordinates[0], item.coordinates[1], distance)
        TrailFinder::Trails.all.select.with_index(1) do |trails, i|
            puts " "
            puts "#{i}. Name: //// #{trails.name} ////"
            puts "   Location: #{trails.location}"
            puts "   Difficulty: #{trails.difficulty}"
            puts "   Star Rating: #{trails.stars}"
        end
    end

    def get_trail_details(choice)
        TrailFinder::Trails.all.select.with_index(1) do |trails, i|
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
                puts " "
            end
        end
    end

    def controller_state
        puts "#{@green}What State is the city in?#{@reset}"
        @input_state = gets.strip.split.map(&:capitalize).join(" ")
        location = TrailFinder::Cities.all.map {|cities| cities.city == @input_city2 && cities.state == @input_state}
        if location == []
            puts " "
            puts "#{@red}We couldn't find #{@input_city2}, #{@input_state} in our database.  Try again or enter the nearest major city.#{@reset}"
            controller_main
        else
            controller_distance
        end
    end

    def controller_distance
        puts "#{@green}How far from your city would you like to search#{@reset}"
        @input_distance = gets.strip
        puts get_trails(@input_city2, @input_state, @input_distance)
        controller_details
    end

    def controller_details
        puts "#{@green}would you like more details on any of these trails? (y/n)#{@reset}"
        input = gets.strip.downcase
        if input == "y" || input == "yes"
            puts "#{@green}Please enter the number of the trail you would like more info on#{@reset}"
            input2 = gets.strip.downcase
            if input2.to_i.between?(1, TrailFinder::Trails.all.count)
                get_trail_details(input2)
                controller_details
            else
                puts "#{@red}There isn't a trail with that input#{@reset}"
                puts " "
                controller_details
            end
        elsif input == "n"
            puts ""
        else
            puts "#{@red}Please enter (y/n).#{@reset}"
            puts " "
            controller_details
        end 
    end

    def over
        puts "#{@yellow}Thanks for riding with us today!#{@reset}"
        puts " "
    end

    def controller_main
        @input_city = nil
        @input_city2 = nil
        @counter = 0
        while @input_city != "Exit"
            if @counter == 0
                where
            else
                where_now
            end
        @input_city = gets.strip.split.map(&:capitalize).join(" ")
            if city_true(@input_city) == true
                @input_city2 = @input_city
                @input_city = "Good Input"
            end
            case @input_city
            when "1"
                puts get_trails(1)
                controller_details
            when "2"
                puts get_trails(2)
                controller_details
            when "3"
                puts get_trails(3)
                controller_details
            when "4"
                puts get_trails(4)
                controller_details
            when "5"
                puts get_trails(5)
                controller_details
            when "Good Input"
                controller_state
            else
                if @input_city != "Exit"
                    puts " "
                    puts "#{@red}Sorry we can't find that city in our database.  Please check the spelling, or use the nearest major city.#{@reset}"
                end
            end
            @counter =+ 1
        end
    end

end
