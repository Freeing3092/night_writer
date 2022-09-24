require './lib/night_writer.rb'

user_input = ARGV

night_writer = NightWriter.new(user_input)

night_writer.repl_output
