
require 'nokogiri'
require 'pry'
require 'date'
require 'open-uri'

module Windfinder
  include Tools

  def self.load(link)
    debut = Time.now
    new_name = link.split("/").last #récupérer la dernière string
    doc = Nokogiri::HTML(URI.open(link)) #ouverture de l'url puis enregistrement de l'html
    rawpage = File.new("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/windfinder_data/#{new_name}.html","w") #création du fichier de stockage
    rawpage.puts doc #on envoie le fichier
    rawpage.close
    fin = Time.now
    parsingtime = fin - debut
    puts "#{new_name} parsé en #{parsingtime} secondes"
  end


  def self.windfinder_forecast(url, tide_mini, tide_max, exposition)

  def self.create_nokogiri_file(url)
    new_name = url.split("/").last
    File.open("/mnt/882A716B2A7156E2/0-Projets/7-forecastproject/bsforecast/data/windfinder_data/#{new_name}.html") { |f| Nokogiri::HTML(f) }
  end

  def self.create_name_file(url)
    url.split("/").last
  end

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

  data_hours = []
  data_tide = []
  file.search('.value').each do |link|
    if link.content.length == 5
      data_tide << link.content
    else data_hours << link.content
    end
end

# puts "il y a #{data_hours.count} données"
# puts "il y a #{data_tide.count} données"

# puts '### Search for wind force'
data_ws = []
file.search('.data-wrap').each do |link|
  data_ws << link.content.delete('^0-9').to_i
end
# puts "il y a #{data_ws.count} données"
# p data_ws

# puts '### Search for wind gust'
data_wg = []
file.search('.data-gusts').each do |link| # je recup une longue string
  data_wg << link.content.delete('^0-9').to_i # je supp les valeurs non numerique de la string
end
# puts "il y a #{data_wg.count} données"
# p data_wg

# puts '### Search for wind deg'
data_wdeg = []
file.search('.units-wd-deg').each do |link|
  data_wdeg << link.content.delete('^0-9').to_i
end
# puts "il y a #{data_wdeg.count} données"

# puts '### Search for wind direction'
data_wdir = []
file.search('.units-wd-dir').each do |link|
  data_wdir << link.content.delete('^A-Z')
end
# puts "il y a #{data_wdir.count} données"

# puts '### Search for wave direction'
data_wvdir = []
file.search('.units-wad-deg').each do |link|
  data_wvdir << link.content.delete('^0-9').to_i
end
# puts "il y a #{data_wvdir.count} données"

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

# puts '### Search for wave tide height'
data_tide_height = []
file.search('.data-tideheight').each do |link|
  data_tide_height << link.content.delete('^0-9').to_i #hauteur d'eau en cm
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
    :model => model_name
  }
  i += 1
  j += 0.125

end
global_data
end

def self.sort_by_sun_hour(data)
  rising_sun = 7
  sunset = 21
  tri_before_sun = data.each.each.select { |k, v| v[:hour].to_i > rising_sun }
  tri_before_sun.each.select { |k, v| v[:hour].to_i < sunset }
end

def self.sort_by_tide(data, tide_mini, tide_max)
  tide_mini = (tide_mini * 10) - 10
  tide_max *= 10

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

def self.sort_by_wind_force(data)
  data.each.select { |k, v| v[:wind_force] > 12}
end

# tri par la direction
def self.sort_by_wind_direction(data, exposition)
  result = []
  exposition = JSON.parse(exposition)
  data.each { |sess|
      exposition.each { |exp|
        if exp == sess[1][:wind_direction]
        result << sess[1]
      else
      end
      }
    }
  result
end

def self.sort_by_timestamp(data)
  data.sort_by! { |result| result[:time_stamp] }
end

def self.display_result(data)
  data.each { |v| puts v[:name] + ' ' + v[:day_name] + ' ' + v[:time_stamp].to_s + ' ' + v[:hour].to_s + ' ' + v[:wind_force].to_s + '|' + v[:wind_gust].to_s + ' ' + v[:wind_direction] + ' ' + (v[:tide_height] == nil ? 'no-tide' :(v[:tide_height] / 10.0).to_s+"m") +'|' + (v[:wave_height] / (10.0)).to_s + 'm ' + v[:wave_direction].to_s + 'deg ' + v[:wave_period].to_s + 's' + ' ' +v[:model] }
end

  new_name = create_name_file(url)
  doc = create_nokogiri_file(url)
  raw_weather_data = parsing_nokogiri_file(doc, new_name)
  data1 = sort_by_sun_hour(raw_weather_data)
  data2 = sort_by_tide(data1, tide_mini, tide_max)
  data3 = sort_by_wind_force(data2)
  sort_by_wind_direction(data3, exposition)
end


end
