module Tools

  def self.convert_deg_to_alpha(ang)
  case ang
  when 0..11 then alpha = 'N'
  when 12..33 then alpha = 'NNE'
  when 34..56 then alpha = 'NE'
  when 57..78 then alpha = 'ENE'
  when 79..101 then alpha = 'E'
  when 102..123 then alpha = 'ESE'
  when 124..146 then alpha = 'SE'
  when 147..168 then alpha = 'SSE'
  when 169..191 then alpha = 'S'
  when 192..213 then alpha = 'SSW'
  when 214..236 then alpha = 'SW'
  when 237..258 then alpha = 'WSW'
  when 259..281 then alpha = 'W'
  when 282..303 then alpha = 'WNW'
  when 304..326 then alpha = 'NW'
  when 327..348 then alpha = 'NNW'
  when 349..359 then alpha = 'NNW'

  end
   return alpha
end

end
