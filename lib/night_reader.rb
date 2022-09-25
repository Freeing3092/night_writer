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
  
  # This method outputs a message to the user indicating the file has been 
  # created with the file created in the data folder.
  def repl_output
    puts "Created '#{@original_message_file}' containing #{@contents.join.size} characters"
    read_and_write
    wrap_english_output
  end
  
  # This method translates the braille file contents to english
  def read_and_write
    File.open("./data/#{@original_message_file}", 'w') do |file|
      loop do
        braille_char = @contents[0..2].map { |row| row[0..1] }
        file.write(@alphabet.key(braille_char))
        delete_translated_characters
        @contents = @contents.drop(3) if @contents[0].empty?
        break if @contents.empty?
      end
    end
  end
  
  # This method deletes the first braille character from the contents attribute
  def delete_translated_characters
    @contents = @contents.each_with_index.map do |row, index|
      if index < 3
        row = row[2..-1] if index < 3
      else
        row = row
      end
    end
  end
  
  # This method will wrap text in the output file if it is longer than 80 
  # english characters
  def wrap_english_output
    unformatted_text = File.open("./data/#{@original_message_file}", 'r').read
    new_line_count = (unformatted_text.size / 80.0).floor
    index = 0
    new_line_count.times do
      new_line_index = unformatted_text[0..(index + 79)].rindex(' ')
      unformatted_text.slice!(new_line_index)
      unformatted_text = unformatted_text.insert(new_line_index, "\n")
      index += 80
    end
    File.open("./data/#{@original_message_file}", 'w') {|file| file.write(unformatted_text)}
  end
  
end


