#CLI Controller
class TrailFinder::CLI

    #Main message starts and runs the program.  Creates a new instance of the City_Scrape class which loads the city data to be used in session
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


    #puts out a numbered list of featured cities based on an array
    def featured_cities
        @f_cities = ["Salt Lake City, Utah", "Austin, Texas", "Bentonville, Arkansas", "Denver, Colorado", "Phoenix, Arizona"]
        puts "1. #{@f_cities[0]}"
        puts "2. #{@f_cities[1]}"
        puts "3. #{@f_cities[2]}"
        puts "4. #{@f_cities[3]}"
        puts "5. #{@f_cities[4]}"
    end

    #puts out a message on the first loop, or after an error that asks the rider for input or gives them an exit option
    def where
        puts " "
        puts "Where would you like to ride? Enter exit at any time to hit the trails."
    end

    #provides an alternative message on the second loop
    def where_now
        puts "* Would you like to find more trails? *"
        puts "Enter a new city to search! Or enter Exit to hit the trails!"
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
        @trails_list = TrailFinder::Get_Trails.new(lat, lon, distance)
        @trails_list.get_trail_list
    end

    #gets trail details based on which trail the rider would like more details on.
    def get_trail_details(choice)
        puts @trails_list.get_trail_details(choice)
        puts " "
    end

    #handles the entry of the riders chosen state
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

    #handles the entry of the riders preferred search distance as well as puts out the trail details to the rider
    def controller_distance
        puts "How far from your city would you like to search"
        @input_distance = gets.strip
        puts get_trails(@input_city2, @input_state, @input_distance)
        controller_details
    end

    #handles asking the rider for input on trail details and puts those trail details out to the rider
    def controller_details
        puts "would you like more details on any of these trails? (y/n)"
        input = gets.strip.downcase
        if input == "y" || input == "yes"
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
            puts "Sorry we couldn't find a trail with that input."
            puts " "
            controller_details
        end 
    end

    #exit message to the rider
    def over
        puts "Thanks for riding with us today!"
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
                    puts "Sorry we can't find that city in our database.  Please check the spelling, or use the nearest major city."
                end
            end
            @counter =+ 1
        end
    end
end
