class TrailFinder::Featured_Cities

    def get_featured
        five = []
        cities = TrailFinder::City_Scrape.doc["records"].map {|arrays| arrays["fields"]}
        selection = cities.select.with_index do |items, i|
            five << "#{items["city"]}, #{items["state"]}"
        end
        five.sample(5)
    end

end
