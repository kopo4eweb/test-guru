module TestPassagesHelper
  def format_of_countdown(time)
    seconds = time % 60
    minuts =  time / 60
    hour =    minuts / 60

    str_hour =    hour < 10 ? "0#{hour}" : hour
    str_minuts =  minuts < 10 ? "0#{minuts}" : minuts
    str_seconds = seconds < 10 ? "0#{seconds}" : seconds
    
    "#{str_hour}:#{str_minuts}:#{str_seconds}"
  end
end
