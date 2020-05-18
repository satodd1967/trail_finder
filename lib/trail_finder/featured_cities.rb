class TrailFinder::Featured_Cities

    def get_featured
        five = []
        cities = TrailFinder::City_Scrape.doc["records"].map {|arrays| arrays["fields"]}
        selection = cities.select do |items|
            five << "#{items["city"]}, #{items["state"]}"
        end
        five.sample(5)
    end

end
