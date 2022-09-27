require "./lib/night_writer"


RSpec.describe NightWriter do
  let(:night_writer) {NightWriter.new(['message.txt', 'braille.txt'])}
  
  context 'initialization' do
    it "exists" do
      expect(night_writer).to be_a NightWriter
    end
    
    it "has readable attributes" do
      expect(night_writer.message).to eq('message.txt')
      expect(night_writer.destination).to eq('braille.txt')
    end
    
    it "is a child of BrailleTranslator" do
      expect(NightWriter.superclass).to eq(BrailleTranslator)
    end
  end 
  
  context 'behavior' do
    
    it "#repl_output returns 'nil' after the message is printed to the
    terminal" do
      expect(night_writer.repl_output).to eq(nil)
    end
    
    it "#repl_output outputs a terminal message indicating the braille file
    created and the character count of the original message" do
      result = "Created 'original_message.txt' containing 11 characters."
      allow(night_writer).to receive(:repl_output).and_return(result)
      expect(night_writer.repl_output).to eq(result)
    end
    
    it "translate_english_to_braille reads input from one file and writes it to another." do
      destination = ('./data/braille.txt')
      
      night_writer.translate_english_to_braille
      
      result = "..0.0.0.0.0......00.0.0.00\n..00.00.0..0....00.0000..0\n.0....0.0.0....0.00.0.0...\n"
      expect(File.open(destination).read).to eq(result)
    end
    
    it "translate_english_to_braille wraps text longer than 40 braille characters or
    80 regular characters." do
      destination = ('./data/braille.txt')
      night_writer = NightWriter.new(['long_message.txt', 'braille.txt'])
      night_writer.translate_english_to_braille
      line_1 = "..0.0.0.0.0......00.0.0.00....0.0.0.0.0......00.0.0.00....0.0.0.0.0.\n"
      line_2 = "..00.00.0..0....00.0000..0....00.00.0..0....00.0000..0....00.00.0..0\n"
      line_3 = ".0....0.0.0....0.00.0.0......0....0.0.0....0.00.0.0......0....0.0.0.\n"
      line_4 = ".....00.0.0.00....0.0.0.0.0......00.0.0.00..\n"
      line_5 = "....00.0000..0....00.00.0..0....00.0000..0..\n"
      line_6 = "...0.00.0.0......0....0.0.0....0.00.0.0.....\n"
      result = line_1.concat(line_2, line_3, line_4, line_5, line_6)
      expect(File.open(destination).read).to eq(result)
    end
    
    it "line_translation translates a line passed as an argument character 
    by character from English to Braille." do
      night_writer = NightWriter.new(['message.txt', 'braille_capitals.txt'])
      file = File.open("./data/braille_capitals.txt", 'w+')
      line = "Hello World"
      
      night_writer.line_translation(line, file)
      file.rewind
      
      result = "..0.0.0.0.0......00.0.0.00\n..00.00.0..0....00.0000..0\n.0....0.0.0....0.00.0.0...\n"
      expect(file.read).to eq(result)
      
    end
    
    it "#is_uppercase? returns boolean value for a character to indicate if
    it is uppercase or lowercase" do
      upper = 'H'
      lower = 'h'
      
      expect(night_writer.is_uppercase?(upper)).to eq(true)
      expect(night_writer.is_uppercase?(lower)).to eq(false)
    end
    
  end
end 
