#CLI Controller

class TrailFinder::CLI

    #main method runs the program
    def call
        intro
        popular_cities
        getinfo
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

    #defines the menue and asks the rider for an input
    def getinfo
        puts "Where would you like to ride?"
    end

end
