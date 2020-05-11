#CLI Controller

class TrailFinder::CLI

    #main method runs the program
    def call
        intro
        featured_cities
        getinfo
        # get_trails_featured(1)
        # trails = Get_Trails.new(33.124, -117.080, 5)
        # trails.get_trail_list
        over
    end

    #puts intro script to the rider
    def intro
        puts "!!!! RIDE FAST CRASH LESS !!!!"
        puts " "
        puts "Welcome Riders!"
        puts " "
        puts "Ride Fast Crash Less is a tool that allows you to input your city and get back all the best trails in your area."
        puts " "
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

    #provides an alternative message on the second loop
    def where_now
        puts "Would you like to find more trails?"
        puts " "
        featured_cities
        puts " "
        puts "Choose another popular city or enter a new city to search"
    end

    def get_trails_featured(choice)
        input = choice.to_i - 1
        city = @f_cities[input].split(",")[0]
        state = @f_cities[input].split(", ")[1]
        location = Coordinates.new(city, state)
        location.get_lat_lon
        lat = location.get_lat
        lon = location.get_lon
        trails = Get_Trails.new(lat, lon)
        trails.get_trail_list
    end

    def get_trails
    end

    #defines the menue and asks the rider for an input
    def getinfo
        input1 = nil
        input2 = 0
        counter = 0
        while input1 != "exit"
            if counter == 0  
                puts " "
                puts "Where would you like to ride? Type exit to hit the trails"
            else
                where_now
            end
                input1 = gets.strip.downcase
                case input1
                when "1"
                    puts get_trails_featured(1)
                when "2"
                    puts get_trails_featured(2)
                when "3"
                    puts get_trails_featured(3)
                when "4"
                    puts get_trails_featured(4)
                when "5"
                    puts get_trails_featured(5)
                when "city"
                    puts "How far from your city would you like to search"
                    input2 = gets.strip.downcase
                    puts "Trails within #{input2} of #{input1}"
                else
                    if input1 != "exit"
                         puts "Can't find any trails within #{input2} miles of #{input1}"
                    end
                end
                counter =+ 1
            end
        end

    def over
        puts "Thanks for riding with us today!"
    end
end
