require 'json'
require 'optparse'

require_relative 'zips_processor'
require_relative 'zips_formatter'

ZIPS_FILE = ENV['ZIPS_FILE'] || 'zips.json'

def zips_processor
  @zips_processor ||= ZipsProcessor.new JSON.parse(File.read(ZIPS_FILE))
end

def output(stuff)
  puts JSON.pretty_generate stuff
end

# Output JSON formatted list of states with populations over 10,000,000
def states_with_populations_above_ten_million
  limit = 10000000

  processed = zips_processor.states_with_populations_above(limit).map do |state, pop|
    ZipsFormatter.state_with_population(state, pop)
  end

  output processed
end

# Output JSON formatted average city population for given state abbreviation
def average_city_population_for(state)
  population = zips_processor.state_average_city_population[state]

  output ZipsFormatter.state_with_average_city_population(state, population)
end

# Output JSON formatted biggest and smallest cities for given state abbreviation
def biggest_and_smallest_city_for(state)
  cities = zips_processor.sorted_cities_by_state[state]

  output ZipsFormatter.state_with_smallest_and_biggest_cities(state, cities.first, cities.last)
end

options = {}

OptParse.new do |parser|
  parser.banner = <<~OPERATIONS
    Usage: zips.rb [options]

      Available operations:
        1. Return States with Populations above 10 Million
        2. Return Average City Population by STATE
        3. Return Largest and Smallest Cities by STATE

  OPERATIONS

  class State
  end

  class Operation
  end

  parser.accept(State) do |state|
    not_found = -> { puts "State not found for code #{state}"; exit }
    state = state.upcase

    zips_processor.states.find(not_found) { |i| i == state }
  end

  parser.accept(Operation) do |operation|
    not_found = -> { puts "Not a valid operation: #{operation}." }
    operation = operation.to_i

    (1..3).find(not_found) { |op| op == operation }
  end

  parser.on('-o', '--operation NUMBER', Operation, 'Select operation to perform by NUMBER') do |operation|
    options.merge!(operation: operation)
  end

  parser.on('-s', '--state STATE', State, 'Return Average City Population by STATE code') do |state|
    options.merge!(state: state)
  end

  parser.on('-h', '--help', 'Display help menu') do
    options.merge!(help: true)
    puts parser
  end
end.parse!

operation = options[:operation]
state = options[:state]

if operation == 1
  states_with_populations_above_ten_million
elsif operation == 2 && state
  average_city_population_for state
elsif operation == 3 && state
  biggest_and_smallest_city_for state
elsif operation
  puts 'To perform this operation please provide a valid -s, --state option.'
end

unless options[:help] || options[:operation]
  puts 'Please select an operation to perform. Use -h, --help to get list.'
end
