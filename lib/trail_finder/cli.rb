#CLI Controller
require "pry"
class TrailFinder::CLI

    #runs the instance mathod colors to set instance variables for text color manipulation
    def initialize
        self.colors
    end

    #Main message starts and runs the program.  Creates a new instance of the City_Scrape class which loads the city data to be used in session
    def call
        puts "Loading..."
        TrailFinder::City_Scrape.new
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

    #puts intro script to the rider
    def intro
        puts " "
        puts "#{@yellow}!!!! RIDE FAST CRASH LESS !!!!"
        puts "       Welcome Riders!#{@reset}"
        puts " "
        puts "Ride Fast Crash Less is a tool that allows you to input your city and get back all the best trails in your area."
        puts "Below is a list of featured cities.  You can either choose one of those by inputing the corresponding number or you can enter your local city."
        puts " "
    end


    #puts out a numbered list of featured cities based on an array
    def featured_cities
        cities = TrailFinder::Featured_Cities.new
        @f_cities = cities.get_featured
        puts "1. #{@f_cities[0]}"
        puts "2. #{@f_cities[1]}"
        puts "3. #{@f_cities[2]}"
        puts "4. #{@f_cities[3]}"
        puts "5. #{@f_cities[4]}"
    end

    #puts out a message on the first loop, or after an error that asks the rider for input or gives them an exit option
    def where
        puts " "
        puts "#{@green}Where would you like to ride? Enter exit to quit.#{@reset}"
    end

    #provides an alternative message on the second loop
    def where_now
        puts "#{@green}* Would you like to find more trails? *"
        puts "Enter a new city to search! Or enter Exit to hit the trails!#{@reset}"
    end

    #Checks the city input by the rider against the database of cities and lat/lon to see if that city is valid
    def city_true(input)
        coordinates = TrailFinder::Coordinates.new
        check = coordinates.city_check(input)
        check
    end

    #gets trails for output based on choosing a city, state and search distance.  City can be chosen by either the number of the featured city or by the actual variables via user input
    def get_trails(city, state = nil, distance = nil)
        if city.to_i.between?(1, 5)
            input = city.to_i - 1
            city_f = @f_cities[input].split(",")[0]
            state_f = @f_cities[input].split(", ")[1]
            location = TrailFinder::Coordinates.new(city_f, state_f)
        else 
            location = TrailFinder::Coordinates.new(city, state)
        end
        lat = location.get_lat
        lon = location.get_lon
        TrailFinder::Get_Trails.new(lat, lon, distance)
        TrailFinder::Get_Trails.list[0].get_trail_list
    end

    #gets trail details based on which trail the rider would like more details on.
    def get_trail_details(choice)
        puts TrailFinder::Get_Trails.list[0].get_trail_details(choice)
        puts " "
    end

    #handles the entry of the riders chosen state
    def controller_state
        puts "#{@green}What State is the city in?#{@reset}"
        @input_state = gets.strip.split.map(&:capitalize).join(" ")
        location = TrailFinder::Coordinates.new(@input_city2, @input_state)
        if location.read_coordinates == []
            puts " "
            puts "#{@red}We couldn't find #{@input_city2}, #{@input_state} in our database.  Try again or enter the nearest major city.#{@reset}"
            controller_main
        else
            controller_distance
        end
    end

    #handles the entry of the riders preferred search distance as well as puts out the trail details to the rider
    def controller_distance
        puts "#{@green}How far from your city would you like to search#{@reset}"
        @input_distance = gets.strip
        puts get_trails(@input_city2, @input_state, @input_distance)
        controller_details
    end

    #handles asking the rider for input on trail details and puts those trail details out to the rider
    def controller_details
        puts "#{@green}would you like more details on any of these trails? (y/n)#{@reset}"
        input = gets.strip.downcase
        if input == "y" || input == "yes"
            puts "#{@green}Please enter the number of the trail you would like more info on#{@reset}"
            input2 = gets.strip.downcase
            if input2.to_i.between?(1, TrailFinder::Get_Trails.list[0].trail_count)
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

    #exit message to the rider
    def over
        puts "#{@yellow}Thanks for riding with us today!#{@reset}"
        puts " "
    end

    #Main controller that handles the process flow of the program.
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

