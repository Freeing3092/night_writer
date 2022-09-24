require './lib/braille_translator'

class NightWriter < BrailleTranslator
  attr_reader :contents, :message, :destination
  
  def initialize(user_input_array)
    @message = user_input_array[0]
    @destination = user_input_array[1]
    @contents = File.open("./data/#{user_input_array[0]}").read
    super()
  end
  
  # This method outputs a message to the user indicating the file has been 
  # created with the file created in the data folder.
  def repl_output
    puts "Created '#{@destination}' containing #{@contents.size} characters"
    read_and_write("./data/#{@message}", "./data/#{@destination}")
  end
  
end