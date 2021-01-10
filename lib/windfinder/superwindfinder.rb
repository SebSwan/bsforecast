require 'nokogiri'
require 'date'
require 'open-uri'

module Superwindfinder

def self.load(link)
  debut = Time.now
  new_name = link.split("/").last
  doc = Nokogiri::HTML(URI.open(link))
  rawpage = File.new("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/superwindfinder_data/#{new_name}_superforecast.html","w")
  rawpage.puts doc
  rawpage.close
  fin = Time.now
  parsingtime = fin - debut
  puts "#{new_name} parsé en #{parsingtime} secondes"
end

end
