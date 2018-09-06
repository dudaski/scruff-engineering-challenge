require_relative 'zips_reader'

class ZipsProcessor
  include ZipsReader

  def initialize(zips)
    @zips = zips
  end

  # Returns array of all city data
  def cities
    @cities ||= get_cities @zips
  end

  # Returns array of all state abbreviations
  def states
    @states ||= cities_by_state.keys
  end

  # Return hash where key is state abbreviation and value is array of cities in
  # that state
  def cities_by_state
    @cities_by_state ||= cities.group_by { |city| get_city_state city }
  end

  # Returns hash where key is state abbreviation and value is population
  def states_with_population
    cities_by_state.transform_values do |cities|
      sum_city_populations_for cities
    end
  end

  # Returns hash containing states_with_population greater than given value
  def states_with_populations_above(value)
    states_with_population.select { |state, population| population > value }
  end

  # Returns hash where key is state abbreviation and value is average population
  def state_average_city_population
    cities_by_state.transform_values do |cities|
      sum_city_populations_for(cities)/cities.length
    end
  end

  # Returns cities_by_state with cities in sorted by population ordered
  # from lowest to highest
  def sorted_cities_by_state
    cities_by_state.transform_values do |cities|
      cities.sort_by { |city| get_city_population city }
    end
  end

  # Return total population given an array of city objects
  def sum_city_populations_for(cities_to_sum)
    cities_to_sum.sum { |city| get_city_population city }
  end
end
