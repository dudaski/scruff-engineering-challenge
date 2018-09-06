require 'spec_helper'
require_relative '../zips_formatter'

describe ZipsFormatter do
  describe '#state_with_population' do
    it 'returns a hash formatted in desired output structure' do
      state = 'ME'
      population = 10

      output = ZipsFormatter.state_with_population(state, population)

      expect(output).to eq({ _id: state, pop: population })
    end
  end

  describe '#state_with_average_city_population' do
    it 'returns a hash formatted in desired output structure' do
      state = 'ME'
      population = 10

      output = ZipsFormatter.state_with_average_city_population(state, population)

      expect(output).to eq({ _id: state, avgCityPop: population })
    end
  end

  describe '#city_with_population' do
    it 'returns a hash formatted in desired output structure' do
      name = 'HOME'
      population = 1

      city = { 'city' => name, 'pop' => population }

      output = ZipsFormatter.city_with_population(city)

      expect(output).to eq({ name: name, pop: population })
    end
  end

  describe '#state_with_smallest_and_biggest_cities' do
    it 'returns a hash formatted in desired output structure' do
      state = 'ME'
      small_city_name = 'HERE'
      small_city_pop = 1
      small_city = {
        'city' => small_city_name,
        'pop' =>  small_city_pop
      }
      big_city_name = 'THERE'
      big_city_pop = 1000000
      big_city = {
        'city' => big_city_name,
        'pop' =>  big_city_pop
      }

      output = ZipsFormatter.state_with_smallest_and_biggest_cities(state, small_city, big_city)

      expect(output).to eq({
          state: state,
          biggestCity: {
            name: big_city_name,
            pop: big_city_pop
          },
          smallestCity: {
            name: small_city_name,
            pop: small_city_pop
          }
        })
    end
  end
end
