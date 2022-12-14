require './lib/braille_translator'

class NightWriter < BrailleTranslator
  attr_reader :contents, :message, :destination
  
  def initialize(user_input_array)
    @message = user_input_array[0]
    @destination = user_input_array[1]
    @contents = File.open("./data/#{user_input_array[0]}").read
    @text_array = format_text_to_array(@contents.downcase)
    super()
  end
  
  # This method runs the program if the user input is valid.
  def self.start
    user_input = ARGV
    if validate_input.nil? 
      night_writer = NightWriter.new(user_input)
      night_writer.repl_output
    end
  end
  
  # This method checks for a valid number of arguments and that
  # the provided file exists.
  def self.validate_input
    if ARGV.size != 2
      puts "Please supply exactly 2 arguments"
      return "Please supply exactly 2 arguments"
    elsif !File.exist?("./data/#{ARGV[0]}")
      puts "Please supply a valid file"
      return "Please supply a valid file"
    end
  end
  
  # This method outputs a message to the user indicating the file has been 
  # created with the file created in the data folder.
  def repl_output
    translate_english_to_braille
    puts "Created '#{@destination}' containing #{@contents.size} characters."
  end
  
  # This method translates characters in the original message to braille
  def translate_english_to_braille
    File.open("./data/#{@destination}", 'w') do |file| 
      @text_array.each do |line|
        for index in 0..2 do
          line.each_char { |chr| file.write(@alphabet[chr][index]) if !@alphabet[chr].nil? }
          file.write("\n")
        end
      end
    end
  end
  
  # This method takes a string argument and translates to an array with
  # elements no longer than 40 english characters
  def format_text_to_array(string)
    text_array = []
    until string.empty? do
      string.size > 40 ? end_line = string.slice(0, 39).rindex(' ') : end_line = (string.size - 1)
      text_array << string[0..(end_line - 1)] if string.size > 40
      text_array << string[0..(end_line)] if string.size < 40
      string.size > 40 ? string = string[(end_line)..-1] : break
    end
    text_array.map { |line| line.strip }
  end
  
end