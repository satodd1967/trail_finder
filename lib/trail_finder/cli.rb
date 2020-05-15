#CLI Controller
require "pry"
class TrailFinder::CLI

    #main method runs the program
    def call
        puts "Loading..."
        TrailFinder::City_Scrape.new
        intro
        featured_cities
        controller_main
        over
    end

    #puts intro script to the rider
    def intro
        puts " "
        puts "!!!! RIDE FAST CRASH LESS !!!!"
        puts " "
        puts "Welcome Riders!"
        puts " "
        puts "Ride Fast Crash Less is a tool that allows you to input your city and get back all the best trails in your area."
        puts "Below is a list of featured cities.  You can either choose one of those by inputing the corresponding number or you can enter your local city."
        puts " "
    end


    #gets the list of most featured cities and puts them to the terminal
    def featured_cities
        @f_cities = ["Salt Lake City, Utah", "Austin, Texas", "Bentonville, Arkansas", "Denver, Colorado", "Phoenix, Arizona"]
        puts "1. #{@f_cities[0]}"
        puts "2. #{@f_cities[1]}"
        puts "3. #{@f_cities[2]}"
        puts "4. #{@f_cities[3]}"
        puts "5. #{@f_cities[4]}"
    end

    def where
        puts " "
        puts "Where would you like to ride? Enter exit at any time to hit the trails."
    end

    #provides an alternative message on the second loop
    def where_now
        puts "* Would you like to find more trails? *"
        puts "Enter a new city to search! Or enter Exit to hit the trails!"
    end

    def city_true(input)
        coordinates = TrailFinder::Coordinates.new
        check = coordinates.city_check(input)
        check
    end

    def get_trails_featured(choice)
        input = choice.to_i - 1
        city = @f_cities[input].split(",")[0]
        state = @f_cities[input].split(", ")[1]
        location = TrailFinder::Coordinates.new(city, state)
        lat = location.get_lat
        lon = location.get_lon
        @trails_list = TrailFinder::Get_Trails.new(lat, lon)
        @trails_list.get_trail_list
    end

    def get_trails(city, state, distance)
        location = TrailFinder::Coordinates.new(city, state)
        lat = location.get_lat
        lon = location.get_lon
        @trails_list = TrailFinder::Get_Trails.new(lat, lon, distance)
        @trails_list.get_trail_list
    end

    def get_trail_details(choice)
        puts @trails_list.get_trail_details(choice)
        puts " "
    end

    def controller_state
        puts "What State is the city in?"
        @input_state = gets.strip.split.map(&:capitalize).join(" ")
        location = TrailFinder::Coordinates.new(@input_city2, @input_state)
        if location.read_coordinates == []
            puts " "
            puts "We couldn't find #{@input_city2}, #{@input_state} in our database.  Try again or enter the nearest major city."
            controller_main
        else
            controller_distance
        end
    end

    def controller_distance
        puts "How far from your city would you like to search"
        @input_distance = gets.strip
        puts get_trails(@input_city2, @input_state, @input_distance)
        controller_details
    end

    def controller_details
        puts "would you like more details on any of these trails? (y/n)"
        input = gets.strip.downcase
        if input == "y"
            puts "Please enter the number of the trail you would like more info on"
            input2 = gets.strip.downcase
            if input2.to_i.between?(1, @trails_list.trail_count)
                get_trail_details(input2)
                controller_details
            else
                puts "There isn't a trail with that input"
                puts " "
                controller_details
            end
        elsif input == "n"
            puts ""
        else
            puts "Sorry didn't understand that."
            puts " "
        end 
    end

    def over
        puts "Thanks for riding with us today!"
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
                puts get_trails_featured(1)
                controller_details
            when "2"
                puts get_trails_featured(2)
                controller_details
            when "3"
                puts get_trails_featured(3)
                controller_details
            when "4"
                puts get_trails_featured(4)
                controller_details
            when "5"
                puts get_trails_featured(5)
                controller_details
            when "Good Input"
                controller_state
            else
                if @input_city != "Exit"
                    puts " "
                    puts "Sorry we can't find that city in our database.  Please check the spelling, or use the nearest major city."
                end
            end
            @counter =+ 1
        end
    end
    # binding .pry
end
