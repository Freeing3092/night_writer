class NightReader
  attr_reader :braille_file,
              :original_message_file,
              :contents
  
  def initialize(user_input_array)
    @braille_file = user_input_array[0]
    @original_message_file = user_input_array[1]
    @contents = File.open("./data/#{user_input_array[0]}").read
  end
  
  # This method outputs a message to the user indicating the file has been 
  # created with the file created in the data folder.
  def repl_output
    puts "Created '#{@original_message_file}' containing #{@contents.size} characters"
    read_and_write("./data/#{@braille_file}", "./data/#{@original_message_file}")
  end
end