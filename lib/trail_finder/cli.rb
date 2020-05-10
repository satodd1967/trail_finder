#CLI Controller

class TrailFinder::CLI

    def call
        puts "Welcome Riders!"
        puts "Ride Fast Crash Less is a tool that allows you to input your city and get back all the best trails in your area."
        puts "Below is a list of the most popular cities.  You can either choose one of those by inputing the corresponding number or you can enter your local city."
        popular_cities
        puts "Where would you like to ride?"
    end

    def popular_cities
        puts "City1"
        puts "City2"
        puts "City3"
        puts "City4"
    end

end
