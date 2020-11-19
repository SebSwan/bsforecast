require 'nokogiri'
require 'open-uri'

class WindfinderJob < ApplicationJob
  queue_as :default

  def perform(link)
    # debut = Time.now
    new_name = link.split("/").last #récupérer la dernière string
    doc = Nokogiri::HTML(URI.open(link)) #ouverture de l'url puis enregistrement de l'html
    rawpage = File.new("../../../bsforecast/data/windfinder_data/#{new_name}.html","w") #création du fichier de stockage
    rawpage.puts doc #on envoie le fichier
    rawpage.close
    # fin = Time.now
    # parsingtime = fin - debut
    # puts "#{new_name} parsé en #{parsingtime} secondes"
    sleep(rand(5))
    end
end
