require './lib/night_reader.rb'

user_input = ARGV

night_reader = NightReader.new(user_input)

night_reader.repl_output
