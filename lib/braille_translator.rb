class BrailleTranslator
  attr_reader :alphabet, :text_array
  
  def initialize
    @alphabet = {'a' => ['0.', '..', '..'],
                'b' => ['0.', '0.', '..'],
                'c' => ['00', '..', '..'],
                'd' => ['00', '.0', '..'],
                'e' => ['0.', '.0', '..'],
                'f' => ['00', '0.', '..'],
                'g' => ['00', '00', '..'],
                'h' => ['0.', '00', '..'],
                'i' => ['.0', '0.', '..'],
                'j' => ['.0', '00', '..'],
                'k' => ['0.', '..', '0.'],
                'l' => ['0.', '0.', '0.'],
                'm' => ['00', '..', '0.'],
                'n' => ['00', '.0', '0.'],
                'o' => ['0.', '.0', '0.'],
                'p' => ['00', '0.', '0.'],
                'q' => ['00', '00', '0.'],
                'r' => ['0.', '00', '0.'],
                's' => ['.0', '0.', '0.'],
                't' => ['.0', '00', '0.'],
                'u' => ['0.', '..', '00'],
                'v' => ['0.', '0.', '00'],
                'w' => ['.0', '00', '.0'],
                'x' => ['00', '..', '00'],
                'y' => ['00', '.0', '00'],
                'z' => ['0.', '.0', '00'],
                ' ' => ['..', '..', '..']
    }
    @text_array =[]
  end
  
  def read_and_write(message, destination)
    text = File.open(message).read.downcase
    format_text_to_array(text)
    File.open(destination, 'w') do |file| 
      @text_array.each do |line|
        for index in 0..2 do
          line.each_char { |chr| file.write(@alphabet[chr][index])}
          file.write("\n")
        end
      end
    end
  end
  
  def format_text_to_array(string)
    until string.empty? do
      string.size > 40 ? end_line = string.slice(0, 39).rindex(' ') : end_line = (string.size - 1)
      @text_array << string[0..(end_line - 1)] if string.size > 40
      @text_array << string[0..(end_line)] if string.size < 40
      string.size > 40 ? string = string[(end_line)..-1] : break
    end
  end
  
end