require_relative 'zips_reader'

module ZipsFormatter
  class << self
    include ZipsReader

    def state_with_population(state, population)
      {
        _id: state,
        pop: population
      }
    end

    def state_with_average_city_population(state, average_city_population)
      {
        _id: state,
        avgCityPop: average_city_population
      }
    end

    def state_with_smallest_and_biggest_cities(state, smallest_city, biggest_city)
      {
        state: state,
        biggestCity: city_with_population(biggest_city),
        smallestCity: city_with_population(smallest_city)
      }
    end

    def city_with_population(city)
      {
        name: get_city_name(city),
        pop: get_city_population(city)
      }
    end
  end
end
