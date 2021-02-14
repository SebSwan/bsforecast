
require 'nokogiri'
require 'date'
require 'open-uri'
require 'active_support/core_ext/object/blank.rb'


module Windfinder
  include Tools

  #reduce the Nokogir::html::document to an array of weather data
  def self.parsing_nokogiri_file(file, name)
    #last update
    update = file.css('#last-update').text

    new_name = name
    model_name = "GFS"
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
    # :accuracy => "  ",
    # :data_day => data_day_number[j.to_i],
    # :month => data_day_month[j.to_i],

    while i < num
      global_data[i] = {
        :name => new_name,
        :time_stamp => data_time[j.to_i],
        :day_name => data_day_name[j.to_i],
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
        :model => model_name,
        :last_update => update
      }
      i += 1
      j += 0.125
    end #while
    return global_data
  end


  #create a .json with weather data in windfinder_data
  def self.dataset_quick(url)
    #load the url
    if url != nil
      debut = Time.now
      new_name = url.split("/").last #take the last word of the string
      raw_url = URI.open(url) #ouverture de l'url
      # create a Nokogiri::HTML::document
      doc = Nokogiri::HTML(raw_url)
      #parse the nokogiri file
      weather_data = Windfinder.parsing_nokogiri_file(doc, new_name)
      #create a file to store the weather data
      data_file = File.new(Rails.root.to_s << "/data/windfinder_data/#{new_name}.json","w") #création du fichier de stockage
      #serialize the weather_data file
      serialized_json_data = weather_data.to_json
      #send serialized data in the weather data storage file
      data_file.puts serialized_json_data
      #save and close the file
      data_file.close
      #performance
      fin = Time.now
      parsingtime = fin - debut
      puts "#{new_name} parsé en #{parsingtime} secondes"
    else puts "url = nil"
    end
  end

  # load all the .json from a spot_list (Spot.all)
  def self.load_all(spot_list)
    multi_url = spot_list.map { |x| x[:windfinder] if x[:active] == true } # array of wf link
    tide_url = spot_list.map { |x| x[:tide_link] if x[:active] == true } # array of wf link
    multi_url += tide_url.select { |x| x != "" }
    # multi_url += tide_url.reject(&:empty?) # reject empty string and add link to main object
    uniq_url = multi_url.uniq # erase  duplicate wf link
    uniq_url.each { |url| Windfinder.dataset_quick(url)
    sleep(rand 5..10)
    } # create .Json file
  end

  def self.one_spot(spot)
    data_set = Windfinder.wizard(spot)
  end

  def self.multi_spot(spot_list)
    result = []
    spot_list.each { |spot|
      wizard = []
      spot[:active] == true ? wizard = Windfinder.one_spot(spot) : ("not loaded")
      wizard.blank? ? (puts "no wizard") : (result << wizard)
    }
    result.flatten
  end

  def self.convert_json_to_data(file_name)
    data_file = File.read(Rails.root + "data/windfinder_data/#{file_name}.json")
    data_array = JSON.parse(data_file)
    puts" #{file_name} converted"
    data_array
  end

  def self.sort_by_sun_hour(data)
    rising_sun = 8
    sunset = 18
    tri_before_sun = data.each.each.select { |k, v| v["hour"].to_i > rising_sun }
    result_array = tri_before_sun.each.select { |k, v| v["hour"].to_i < sunset }
    puts "self.sort_by_sun_hour(#{result_array.count})"
    result_array
  end

  def self.sort_by_wind_force_mini(data,spot)
    result = data.each.select { |k, v| v["wind_force"] > spot["wind_force_mini"]}
    puts "self.sort_by_wind_force_mini(#{result.count})"
    result
  end

  def self.sort_by_wind_force_maxi(data,spot)
    result = data.each.select { |k, v| v["wind_force"] < spot["wind_force_maxi"]}
    puts "self.sort_by_wind_force_maxi(#{result.count})"
    result
  end

  def self.sort_by_wind_direction(data, spot)
    result = []
    data.each { |sess|
     spot.wind_directions.each { |exp|
       if exp.direction == sess[1]["wind_direction"]
        result << sess[1]
     else
    end
    }
  }
  puts "self.sort_by_wind_direction (#{result.count})"
  result
  end

  def self.sort_by_tide_mini(data, spot)
    tide_mini = spot[:tide_mini]
    if data !=[]
      case data.first["tide_height"]
        when 0..13
          puts "Tide data OK"
          tide_sorted = data.each.select { |v| v["tide_height"] > tide_mini}
          puts "(#{tide_sorted.count}) spot up to low tide"
          data = tide_sorted
        when nil
          puts "no Tide data in .JSON"
        data
        else
          puts "no data, weather_data = []"
          puts "////////////////////////tide stuff to solve////////////////////////////"
          puts data
        data
      end
    end
    data
  end

  def self.sort_by_tide_max(data, spot)
    tide_max = spot[:tide_max]
    if data!=[]
      case data.first["tide_height"]
      when 0..13
        puts "Tide data OK"
        tide_sorted = data.each.select { |v| v["tide_height"] < tide_max}
        puts "(#{tide_sorted.count}) spot under the up tide level"
        data = tide_sorted
      when nil
        puts "no Tide data in .JSON"
        data
      else
        puts "no data, weather_data = []"
        puts "////////////////////////tide stuff////////////////////////////"
        puts data
        data
      end
    end
    data
  end

  def self.sort_by_wave_direction(data, spot)
    result = []
    data.each { |sess|
      spot.wave_directions.each { |exp|
        if exp.direction == sess["wave_direction"]
        result << sess
      else
      end
    }
  }
    puts "self.sort_by_wave_direction (#{result.count})"
    result
  end

  def self.sort_by_wave_height_mini(data,spot)
    if data!=[]
      result = data.each.select { |k| (k["wave_height"]/10.0) > spot["wave_height_mini"]}
      puts "self.sort_by_wave_height_mini(#{result.count})"
    else
      puts "no data, weather_data = []"
      result = data
    end
    result
  end

  def self.sort_by_wave_height_maxi(data,spot)
    if data!=[]
      result = data.each.select { |k| (k["wave_height"]/10.0) < spot["wave_height_maxi"]}
      puts "self.sort_by_wave_height_maxi(#{result.count})"
    else
      puts "no data, weather_data = []"
      result = data
    end
    result
  end

  def self.sort_by_wave_period_mini(data,spot)
    if data!=[]
      result = data.each.select { |k| (k["wave_period"]) > spot["periode_mini"]}
      puts "self.sort_by_wave_period_mini(#{result.count})"
    else
      puts "no data, weather_data = []"
      result = data
    end
    result
  end

  def self.sort_by_wave_period_maxi(data,spot)
      if data!=[]
        result = data.each.select { |k| (k["wave_period"]) < spot["periode_maxi"]}
        puts "self.sort_by_wave_period_max(#{result.count})"
      else
        puts "no data, weather_data = []"
        result = data
      end
      result
  end
  #sorting algorithm ->
  def self.wizard(spot)
    puts "///////////////////////#{spot[:label]}/////////////////////////////////////"
    file_name = spot[:windfinder].split("/").last
    weather_data = Windfinder.convert_json_to_data(file_name)
    # add tide in the data if not exist yet
    if spot[:tide_link].present?
      weather_data = Windfinder.add_custom_tide(weather_data, spot[:tide_link])
    else
      puts 'not custom tide data detected'
    end

    # add the sport attribute to the hash
    weather_data.each {|x, y|
      y.merge!('sport' => spot['sport'])
      y.merge!('label' => spot['label'])
    }
    # sort day and night
    weather_data = Windfinder.sort_by_sun_hour(weather_data)
    # sort by wind_force_mini
    spot[:wind_force_mini].nil? || spot[:wind_force_mini] == 0 ? (puts 'no wind_force_mini') : (weather_data = Windfinder.sort_by_wind_force_mini(weather_data,spot))
    # sort by wind_force_maxi
    spot[:wind_force_maxi].nil? || spot[:wind_force_maxi] == 0 ? (puts 'no wind_force_maxi') : (weather_data = Windfinder.sort_by_wind_force_maxi(weather_data,spot))
    # sort by wave_direction
    spot.wind_directions == [] ? (puts 'no wind direction') : (weather_data = Windfinder.sort_by_wind_direction(weather_data,spot))
    # sort by tide_mini
    spot[:tide_mini].nil? || spot[:tide_mini] == 0 ? (puts 'no tide mini') : (weather_data = Windfinder.sort_by_tide_mini(weather_data,spot))
    # sort by tide_max
    spot[:tide_max].nil? || spot[:tide_maxi] == 0 ? (puts 'no tide max') : (weather_data = Windfinder.sort_by_tide_max(weather_data,spot))
    # sort by wave_direction
    spot.wave_directions == [] ? (puts 'no wave direction') : (weather_data = Windfinder.sort_by_wave_direction(weather_data,spot))
    # sort by wave_height_mini
    spot[:wave_height_mini].nil? || spot[:wave_height_mini] == 0  ? (puts 'no minimum wave height') : (weather_data = Windfinder.sort_by_wave_height_mini(weather_data,spot))
    # sort by wave_height_maxi
    spot[:wave_height_maxi].nil? || spot[:wave_height_maxi] == 0  ? (puts 'no maximum wave height') : (weather_data = Windfinder.sort_by_wave_height_maxi(weather_data,spot))
    # sort by wave_period_mini
    spot[:periode_mini].nil? || spot[:periode_mini] == 0  ? (puts 'no minimum wave period') : (weather_data = Windfinder.sort_by_wave_period_mini(weather_data,spot))
    # sort by wave_period_maxi
    spot[:periode_maxi].nil? || spot[:periode_maxi] == 0  ? (puts 'no maximum wave period') : (weather_data = Windfinder.sort_by_wave_period_maxi(weather_data,spot))

    weather_data.nil? ? (puts 'no weather data') : (puts "# {weather_data.count}")
    weather_data.blank? ? (puts 'weather data empty') : (puts "#{weather_data.count}")

    weather_data
  end

  ###############################not validate######################################

  def self.sort_by_timestamp(data)
    data.sort_by { |result| [result['time_stamp'], result['hour']] }
  end

  def self.add_custom_tide(json_file, tide_link)
    # verifier si le fichier tide_link est present dans data/windfinder
    tide_spot_name = tide_link.split("/").last
    tide_spot = Windfinder.convert_json_to_data(tide_spot_name)
    # si oui

    json_file.each_with_index { |arr, index|
            arr[1]['tide_height'] = tide_spot[index.to_s]['tide_height']
            arr[1]['tide_direction'] = tide_spot[index.to_s]['tide_direction']
            arr[1]['tide_hour'] = tide_spot[index.to_s]['tide_hour'] }
    json_file
  end

  def self.test
    puts "####################################################"
    puts "##################WHENEVER WORK####################"
    puts "#{Time.now}"
    puts "####################################################"
  end
end
