require 'nokogiri'
require 'open-uri'

module Shom
  def self.load(link, spot_name)
  debut = Time.now
  new_name = spot_name
  doc = Nokogiri::HTML(URI.open(link))
  rawpage = File.new("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/shom_data/#{new_name}.html","w")
  rawpage.puts doc
  rawpage.close
  fin = Time.now
  parsingtime = fin - debut
  puts "#{new_name} parsé en #{parsingtime} secondes"
  end

end

