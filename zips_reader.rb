# module containing methods for extracting values from zips related objects
module ZipsReader

  # Returns array of cities objects from a zips hash
  def get_cities(zips)
    zips['cities']
  end

  # Returns the name value of a city from the city hash
  def get_city_name(city)
    city['city']
  end

  # Returns the population value of a city from a city hash
  def get_city_population(city)
    city['pop']
  end

  # Returns the state value of a city hash
  def get_city_state(city)
    city['state']
  end
end
