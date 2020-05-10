#CLI Controller

class TrailFinder::CLI

    #main method runs the program
    def call
        intro
        popular_cities
        getinfo
        over
    end

    #puts intro script to the rider
    def intro
        puts "Welcome Riders!"
        puts "Ride Fast Crash Less is a tool that allows you to input your city and get back all the best trails in your area."
        puts "Below is a list of the most popular cities.  You can either choose one of those by inputing the corresponding number or you can enter your local city."
    end

    #gets the list of most popular cities and puts them to the terminal
    def popular_cities
        puts "City1"
        puts "City2"
        puts "City3"
        puts "City4"
    end

    def where_now
        puts "Would you like to find more trails?"
        popular_cities
        puts "Choose another popular city or enter a new city to search"
    end

    #defines the menue and asks the rider for an input
    def getinfo
        input1 = nil
        input2 = 0
        counter = 0
        while input1 != "exit"
            if counter == 0  
                puts "Where would you like to ride? Type exit to hit the trails"
            else
                where_now
            end
                input1 = gets.strip.downcase
                case input1
                when "1"
                    puts "Trails for city 1"
                when "2"
                    puts "Trails for City 2"
                when "3"
                    puts "Trails for City 3"
                when "4"
                    puts "Trails for City 4"
                when "5"
                    puts "Trails for City 5"
                when "city"
                    puts "How far from your city would you like to search"
                    input2 = gets.strip.downcase
                    puts "Trails within #{input2} of #{input1}"
                else
                    puts "Can't find any trails within #{input2} miles of #{input1}"
                end
                counter =+ 1
            end
        end

    def over
        puts "Thanks for riding with us today!"
    end
end
