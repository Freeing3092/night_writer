require './lib/braille_translator'

class NightReader < BrailleTranslator
  attr_reader :braille_file,
              :original_message_file,
              :contents
  
  def initialize(user_input_array)
    @braille_file = user_input_array[0]
    @original_message_file = user_input_array[1]
    @contents = File.open("./data/#{user_input_array[0]}").read.split("\n")
    super()
  end
  
  # This method runs the program if the user input is valid.
  def self.start
    user_input = ARGV
    if validate_input.nil? 
      night_reader = NightReader.new(user_input)
      night_reader.repl_output
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
    translate_braille_to_english
    wrap_english_output
    characters = File.open("./data/#{@braille_file}").read.split("\n").join.size/6
    puts "Created '#{@original_message_file}' containing #{characters} characters."
  end
  
  # This method translates the braille file contents to english
  def translate_braille_to_english
    File.open("./data/#{@original_message_file}", 'w') do |file|
      while !@contents.empty?
        if !@contents[3].nil?
          file.write(@alphabet.key(['..', '..', '..'])) if @contents[0].empty? && @contents[3][0] != '..'
        end
        @contents = @contents.drop(3) if @contents[0].empty?
        braille_character = @contents[0..2].map { |row| row[0..1] }
        file.write(@alphabet.key(braille_character))
        delete_translated_characters
      end
    end
  end
  
  # This method deletes the first braille character from the contents attribute
  def delete_translated_characters
    @contents = @contents.each_with_index.map do |row, index|
      index < 3 ? row = row[2..-1] : row = row
    end
  end
  
  # This method will wrap text in the output file if it is longer than 80 
  # english characters
  def wrap_english_output
    unformatted_text = File.open("./data/#{@original_message_file}", 'r').read
    new_line_count = unformatted_text.size / 80
    index = 0
    formatted_text = insert_new_lines(unformatted_text, new_line_count, index)
    File.open("./data/#{@original_message_file}", 'w') {|file| file.write(formatted_text)}
  end
  
  # This method inserts new lines at the index position of the first whitespace
  # preceding the 79 index position of each line
  def insert_new_lines(unformatted_text, number_of_new_lines, index)
    number_of_new_lines.times do
      new_line_index = unformatted_text[0..(index + 79)].rindex(' ')
      unformatted_text.slice!(new_line_index)
      index += 80
      unformatted_text = unformatted_text.insert(new_line_index, "\n")
    end
    unformatted_text
  end
  
end