
require 'nokogiri'
require 'pry'
require 'date'
require 'open-uri'

module Windfinder
  include Tools

  #1
  def self.load(link) #dowload HTML file in /local
    debut = Time.now
    new_name = link.split("/").last #récupérer la dernière string
    doc = Nokogiri::HTML(URI.open(link)) #ouverture de l'url puis enregistrement de l'html
    rawpage = File.new("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/windfinder_data/#{new_name}.html","w") #création du fichier de stockage
    rawpage.puts doc #on envoie le fichier
    rawpage.close
    fin = Time.now
    parsingtime = fin - debut
    puts "#{new_name} parsé en #{parsingtime} secondes"
  end #self.load

  #2
  def self.create_nokogiri_file(url) #creation du fichier nokogiri
    new_name = url.split("/").last
    puts"self.create_nokogiri_file(url)"
    File.open("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/windfinder_data/#{new_name}.html") { |f| Nokogiri::HTML(f) }
  end

  #3
  def self.create_name_file(url)
    puts "self.create_name_file(url)"
    url.split("/").last
  end

  #4
  def self.parsing_nokogiri_file(file, name)

    new_name = name
    model_name = "wf"
    data_day_name = []
    data_time = []

    file.search('.weathertable__headline').each do |link|
      data_time << Date.parse(link.text).strftime('%d-%m')
      data_day_name << Date.parse(link.text).strftime('%A')
      # data_day_number << Date.parse(link.text).day
      # data_day_month << Date.parse(link.text).month
    end

    data_hours = [] #parse hours 1 tide each X value, need to sort
    data_tide = []
    file.search('.value').each do |link|
      if link.content.length == 5
        data_tide << link.content
        else data_hours << link.content
      end
    end

    # puts '### Search for wind force'
    data_ws = []
    file.search('.data-wrap').each do |link|
      data_ws << link.content.delete('^0-9').to_i
    end

    data_wg = []
    file.search('.data-gusts').each do |link| # je recup une longue string
      data_wg << link.content.delete('^0-9').to_i # je supp les valeurs non numerique de la string
    end

    data_wdeg = []
    file.search('.units-wd-deg').each do |link|
      data_wdeg << link.content.delete('^0-9').to_i
    end

    # puts '### Search for wind direction'
    data_wdir = []
    file.search('.units-wd-dir').each do |link|
      data_wdir << link.content.delete('^A-Z')
    end

    # puts '### Search for wave direction'
    data_wvdir = []
    file.search('.units-wad-deg').each do |link|
      data_wvdir << link.content.delete('^0-9').to_i
    end

    # puts '### Search for wave height'
    data_wh = []
    file.search('.data-waveheight').each do |link|
      data_wh << link.content.delete('^0-9').to_i
    end
    # puts "il y a #{data_wh.count} données"

    # puts '### Search for wave period'
    data_wp = []
    file.search('.data-wavefreq').each do |link|
      data_wp << link.content.delete('^0-9').to_i
    end
    # puts "il y a #{data_wh.count} données"

    # # puts '### Search for wave tide height'
    # data_tide_height = []
    # file.search('.data-tideheight').each do |link|
    #   data_tide_height << link.content.delete('^0-9').to_i #hauteur d'eau en cm
    # end

    # tendance de la maréé tide-high","tide-down","tide-low","tide-low",

    data_tide_direction = []
    file.search('.data-tidedirection__symbol').each do |link|
      data_tide_direction << (link.first.last)[37..-1]
    end

    # heure de la marée
    data_tide_hour = []
    file.search('.data-tidefreq').each do |link|
      result = link.content.strip #[53..-1] #.match /(\d{2}:\d{2})/)
      data_tide_hour << result
    end

    #hauteur dela marée
    data_tide_height = []
    file.search('.data-tideheight').each do |link|
      data_tide_height << link.content.to_f
    end

    ## pluie
    data_rain = []
    file.search('.data-rain').each do |link|
      data_rain << link.content.to_i
    end

    # temperature
    data_temp = []
    file.search('.data-temp').each do |link|
      data_temp << link.content.to_i
    end

    # pression
    data_pression = []
    file.search('.data-pressure').each do |link|
      data_pression << link.content.to_i
    end

    global_data = Hash.new

    i = 0
    j = 0
    num = data_ws.count

    while i < num
      global_data[i] = {
        :accuracy => "  ",
        :name => new_name,
        :time_stamp => data_time[j.to_i],
        :day_name => data_day_name[j.to_i],
        # :data_day => data_day_number[j.to_i],
        # :month => data_day_month[j.to_i],
        :hour => data_hours[i],
        :wind_force => data_ws[i],
        :wind_gust => data_wg[i],
        :wind_direction => data_wdir[i],
        :wind_degree => data_wdeg[i],
        :wave_height => data_wh[i],
        :wave_degree => data_wvdir[i],
        :wave_direction => Tools::convert_deg_to_alpha(data_wvdir[i]),
        :wave_period => data_wp[i],
        :tide_height => data_tide_height[i],
        :tide_direction => data_tide_direction[i],
        :tide_hour => data_tide_hour[i],
        :rain_mm => data_rain[i],
        :pression => data_pression[i],
        :temperature => data_temp[i],
        :model => model_name
      }
      i += 1
      j += 0.125
    end #while
    return global_data
  end

#methode qui regroupe les autres méthodes
  def self.dataset(url)
    #Windfinder.load(url) #1
    file = Windfinder.create_nokogiri_file(url) #2
    name = Windfinder.create_name_file(url) #3
    puts "self.forecast check"
    Windfinder.parsing_nokogiri_file(file, name) #4
  end

  def self.sort_by_sun_hour(data)
    rising_sun = 7
    sunset = 21
    puts "self.sort_by_sun_hour(data)"
    tri_before_sun = data.each.each.select { |k, v| v[:hour].to_i > rising_sun }
    tri_before_sun.each.select { |k, v| v[:hour].to_i < sunset }
  end

  def self.sort_by_wind_force(data)
    puts "self.sort_by_wind_force(data)"
    data.each.select { |k, v| v[:wind_force] > 12}
  end


  def self.sort_by_wind_direction(data, spot)
  result = []
  data.each { |sess|
    spot.wind_directions.each { |exp|
      if exp.direction == sess[1][:wind_direction]
        result << sess[1]
      else
      end
    }
  }
  puts "self.sort_by_wind_direction"
  result
  end

  def self.sort_by_tide(data, tide_mini, tide_max)
    tide_mini = tide_mini - 1


    if data.first[1][:tide_height].nil? == false
      # puts "Tide data OK"
      #tri par maree haute puis basse
      tri_up_tide = data.each.each.select { |k, v| v[:tide_height] < tide_max}

      # puts "#{tri_up_tide.count}spot sous le seuil haut de marée"

      tri_low_tide = tri_up_tide.each.select { |k, v| v[:tide_height] > tide_mini}

      # puts "#{tri_low_tide.count}spot au dessus du seuil bas de marée"
      final_data = tri_low_tide

    else puts "Tide data empty"
      final_data = data
    end
    final_data
  end


  def self.sort(data)
    puts"self.sort(data)"
    data1 = Windfinder.sort_by_sun_hour(data)
    data2 = Windfinder.sort_by_wind_force(data1)
  end

  def self.test(data, spot)

  end

end
