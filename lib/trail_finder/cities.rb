
require "nokogiri"
require "open-uri"

doc = Nokogiri::HTML(open("https://gist.github.com/Miserlou/c5cd8364bf9b2420bb29"))
puts doc.css(".pl-s").css(".pl-pds").value


