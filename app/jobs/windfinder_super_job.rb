require 'nokogiri'
require 'open-uri'

class WindfinderSuperJob < ApplicationJob
  queue_as :default

  def perform(link)

  new_name = link.split("/").last
  doc = Nokogiri::HTML(URI.open(link))
  rawpage = File.new("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/superwindfinder_data/#{new_name}.html","w")
  rawpage.puts doc
  rawpage.close
  sleep(rand(5))
  end
end
