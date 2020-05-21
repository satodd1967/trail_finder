
class TrailFinder::CLI

    #initializes the CLI instance with instance variables for the colors used in output as well as the two input variables that are used in all of the controller methods
    def initialize
        @red = "\u001b[31m"
        @green = "\u001b[32m"
        @yellow = "\u001b[33m"
        @blue = "\u001b[34m"
        @reset = "\u001b[0m"
        @input_city = nil
        @input_city2 = nil
        @input_state = nil
    end

    #starts the application by scraping cities from the web and creating instances of them, welcoming the user, showing the featured cities(random cities) and starting the main controller
    def call
        puts "Loading..."
        TrailFinder::City_Scrape.api_call
        intro
        featured_cities
        controller_main
        over
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

    #utilizes the featured cities method in the Cities class to pull back 5 random cities to be featured cities in the app
    def featured_cities
        TrailFinder::Cities.featured_cities
    end

    #opening question for user input on the first loop of the app
    def where
        puts " "
        puts "#{@green}Where would you like to ride? Enter exit to quit.#{@reset}"
    end

    #second input question for the user on the second and additional loops of the app
    def where_now
        puts "#{@green}* Would you like to find more trails? *"
        puts "Enter a new city to search! Or enter Exit to hit the trails!#{@reset}"
    end

    #checks to make sure that the city that the user input is in the database of cities and is valid
    def city_true(input)
        TrailFinder::Cities.all.map {|cities| cities.city}.include?(input)
    end

    #scrapes and put trails from the web based on the user either choosing a featured city or entering a city, state and search distance.
    def get_trails(city, state = nil, distance = nil)
        found_city = TrailFinder::Cities.get_city(city, state, distance)
        TrailFinder::Trails.destroy
        TrailFinder::Trail_Scrape.api_call(found_city.coordinates[0], found_city.coordinates[1], distance)
        TrailFinder::Trails.get_trails
    end

    #gets additional information on the user selected trail and also opens the corresponding trail page on the MTB Project
    def get_trail_details(choice)
        TrailFinder::Trails.get_trail_details(choice)
    end

    #checks to make sure that the valid city selection and the state input make a valid city and state combination for the app
    def controller_state
        puts "#{@green}What State is the city in?#{@reset}"
        @input_state = gets.strip.split.map(&:capitalize).join(" ")
        location = TrailFinder::Cities.state_check(@input_city2, @input_state)
        if location == nil
            puts " "
            puts "#{@red}We couldn't find #{@input_city2}, #{@input_state} in our database.  Try again or enter the nearest major city.#{@reset}"
            controller_main
        else
            controller_distance
        end
    end

    #takes in the user input for search distance and then outputs the results to the user
    def controller_distance
        puts "#{@green}How far from your city would you like to search#{@reset}"
        @input_distance = gets.strip
        puts get_trails(@input_city2, @input_state, @input_distance)
        controller_details
    end

    #takes in user input on a request for additonal trail details and puts the details to the user
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

    #ending message for the user
    def over
        puts "#{@yellow}Thanks for riding with us today!#{@reset}"
        puts " "
    end

    #main controller for the application runs the main program loop and takes in the users initial input
    def controller_main
        @input_city = nil
        @input_city2 = nil
        counter = 0
        while @input_city != "Exit"
            if counter == 0
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
            when "1".."5"
                puts get_trails(@input_city)
                controller_details
            when "Good Input"
                controller_state
            else
                if @input_city != "Exit"
                    puts " "
                    puts "#{@red}Sorry we can't find that city in our database.  Please check the spelling, or use the nearest major city.#{@reset}"
                end
            end
            counter =+ 1
        end
    end

end
