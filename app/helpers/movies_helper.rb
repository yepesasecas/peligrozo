module MoviesHelper
  def select_theater_options(favorite_theaters, theaters, disabled)
    _theaters = theaters.map { |theater| [theater.name, theater.id] }
    _favorite = favorite_theaters.map { |theater| [theater.name, theater.id] }

    options = if favorite_theaters.empty?
      ["Teatros"] + _theaters
    else
      ["Teatros Favoritos"] + _favorite + ["Teatros"] + _theaters
    end
    options_for_select options, disabled: ["Teatros Favoritos", "Teatros"]
  end
end
