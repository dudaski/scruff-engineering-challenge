require 'spec_helper'
require_relative '../zips_reader'

class TestClass
  include ZipsReader
end

describe ZipsReader do
  before(:each) do
    @test_class = TestClass.new
    @city = {
      'city' => 'home',
      'pop' =>  1,
      'state' => 'mindless'
    }
  end

  describe '.get_cities' do
    it 'returns the cities value from a zips hash' do
      @zips = Hash['cities', [@city]]

      expect(@test_class.get_cities(@zips)).to eq [@city]
    end
  end

  describe '.get_city_name' do
    it 'returns the city value from a city hash' do
      expect(@test_class.get_city_name(@city)).to eq 'home'
    end
  end

  describe '.get_city_population' do
    it 'returns the population value from a city hash' do
      expect(@test_class.get_city_population(@city)).to eq 1
    end
  end

  describe '.get_city_state' do
    it 'returns the population value from a city hash' do
      expect(@test_class.get_city_state(@city)).to eq 'mindless'
    end
  end
end
