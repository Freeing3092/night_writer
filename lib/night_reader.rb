class NightReader
  attr_reader :braille_file,
              :original_message_file
  
  def initialize(user_input_array)
    @braille_file = user_input_array[0]
    @original_message_file = user_input_array[1]
  end
end