module ApplicationHelper
 
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def movie_match
    count = Movie.with_no_trailer.count
    if count > 0
      "MOVIE MATCH (#{count})"
    else
      "MOVIE MATCH"
    end
  end
  
end
