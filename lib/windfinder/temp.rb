


     # binding.pry
  end #parsing_nokogiri_file

  #
  # def self.sort_by_tide(data, tide_mini, tide_max)
  #   tide_mini = (tide_mini * 10) - 10
  #   tide_max *= 10

  #   if data.first[1][:tide_height].nil? == false
  #     # puts "Tide data OK"
  #     #tri par maree haute puis basse
  #     tri_up_tide = data.each.each.select { |k, v| v[:tide_height] < tide_max}

  #     # puts "#{tri_up_tide.count}spot sous le seuil haut de marée"

  #     tri_low_tide = tri_up_tide.each.select { |k, v| v[:tide_height] > tide_mini}

  #     # puts "#{tri_low_tide.count}spot au dessus du seuil bas de marée"
  #     final_data = tri_low_tide

  #   else puts "Tide data empty"
  #     final_data = data
  #   end
  #   final_data
  # end

  # def self.sort_by_wind_force(data)
  #   data.each.select { |k, v| v[:wind_force] > 12}
  # end

  # tri par la direction
    # def self.sort_by_wind_direction(data, exposition)
    # result = []
    # exposition = JSON.parse(exposition)
    # data.each { |sess|
    #   exposition.each { |exp|
    #     if exp == sess[1][:wind_direction]
    #         result << sess[1]
    #       else
    #       end
    #     }
    #   }
    #   result
    # end #def self.sort_by_wind_direction(data, exposition)

    # def self.sort_by_timestamp(data)
    #   data.sort_by! { |result| result[:time_stamp] }
    # end

    # def self.display_result(data)
    #   data.each { |v| puts v[:name] + ' ' + v[:day_name] + ' ' + v[:time_stamp].to_s + ' ' + v[:hour].to_s + ' ' + v[:wind_force].to_s + '|' + v[:wind_gust].to_s + ' ' + v[:wind_direction] + ' ' + (v[:tide_height] == nil ? 'no-tide' :(v[:tide_height] / 10.0).to_s+"m") +'|' + (v[:wave_height] / (10.0)).to_s + 'm ' + v[:wave_direction].to_s + 'deg ' + v[:wave_period].to_s + 's' + ' ' +v[:model] }
    # end

    new_name = create_name_file(url)
    doc = create_nokogiri_file(url)
    raw_weather_data = parsing_nokogiri_file(doc, new_name)
    # data1 = sort_by_sun_hour(raw_weather_data)
    # data2 = sort_by_tide(data1, tide_mini, tide_max)
    # data3 = sort_by_wind_force(data2)
    # sort_by_wind_direction(data3, exposition)

  binding.pry
end #windfinder
