require './lib/braille_translator'
require 'enumerator'

class NightWriter < BrailleTranslator
  attr_reader :contents, :message, :destination, :unformatted_text
  
  def initialize(user_input_array)
    @message = user_input_array[0]
    @destination = user_input_array[1]
    @contents = File.open("./data/#{user_input_array[0]}").read
    @unformatted_text = unformatted_text
    # @text_array = format_text_to_array(@contents.downcase)
    super()
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
      line_translation(@contents, file)
    end
    wrap_braille_output
  end
  
  # The method wraps the braille text in the output file
  def wrap_braille_output
    File.open("./data/#{@destination}", 'r+') do |file|
      @unformatted_text = file.readlines
      file.rewind
      braille_chars = file.readlines.map {|line| line.scan(/.{1,2}/)}.transpose
      insert_new_lines_braille(braille_chars)
    end
    require "pry"; binding.pry
    File.open("./data/#{@destination}", 'w') do |file| 
      @unformatted_text.each {|line| file.write(line)}
    end
  end
  
  # This method inserts new lines at the index position of the first whitespace
  # preceding the 79 index position of each file
  
  def insert_new_lines_braille(braille_chars)
    index = 0
    new_line_count = @unformatted_text.first.size / 80
    new_line_count.times do 
      end_line = braille_chars.slice(0, index + 39).rindex(@alphabet[' ']) * 2
      @unformatted_text.map! {|line| line.insert(end_line, "\n") }
      index += 40
    end
  end
  
  # This method takes a line (of english characters) and an open file as
  # arguments and translates the line to braille in the open file.
  def line_translation(line, open_file)
    for index in 0..2 do
      line.each_char do |chr|
        open_file.write(@alphabet['shift'][index]) if is_uppercase?(chr)
        open_file.write(@alphabet[chr.downcase][index]) if !@alphabet[chr.downcase].nil?
      end
      open_file.write("\n")
    end
  end
  
  # This method returns a boolean value indicating if the argument is uppercase
  def is_uppercase?(character)
    !/[[:upper:]]/.match(character).nil?
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