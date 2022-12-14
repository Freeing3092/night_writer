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
    
    it "#validate_input checks the user input for the correct number of arguments
    and a valid filename" do
      stub_const('Object::ARGV', ['message.txt', 'braille.txt', 'extra.txt'])
      expect(NightWriter.validate_input).to eq("Please supply exactly 2 arguments")
      
      stub_const('Object::ARGV', ['message.txt'])
      expect(NightWriter.validate_input).to eq("Please supply exactly 2 arguments")
      
      stub_const('Object::ARGV', ['messagee.txt', 'braille.txt'])
      expect(NightWriter.validate_input).to eq("Please supply a valid file")
      
      stub_const('Object::ARGV', ['message.txt', 'braille.txt'])
      expect(NightWriter.validate_input).to eq(nil)
    end
    
    it "#start creates an instance of NightWriter if valid input is provided" do
      stub_const('Object::ARGV', ['message.txt', 'braille.txt', 'extra.txt'])
      expect(NightWriter.start).to eq(nil)
      
      stub_const('Object::ARGV', ['message.txt'])
      expect(NightWriter.start).to eq(nil)
      
      stub_const('Object::ARGV', ['messagee.txt', 'braille.txt'])
      expect(NightWriter.start).to eq(nil)
      
      stub_const('Object::ARGV', ['message.txt', 'braille.txt'])
      expect(NightWriter.start).to eq(nil)
    end
    
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
      
      result = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"
      expect(File.open(destination).read).to eq(result)
    end
    
    it "format_text_to_array takes a string as an argument and sorts into
    arrays no longer than 40 characters, with leading and trailing whitespace
    removed" do
      string = "Hello World Hello World Hello World Hello World "
      result = ["Hello World Hello World Hello World", "Hello World"]
      
      expect(night_writer.format_text_to_array(string)).to eq(result)
    end
    
    it "translate_english_to_braille wraps text longer than 40 braille characters or
    80 regular characters." do
      destination = ('./data/braille.txt')
      night_writer = NightWriter.new(['long_message.txt', 'braille.txt'])
      night_writer.translate_english_to_braille
      line_1 = "0.0.0.0.0....00.0.0.00..0.0.0.0.0....00.0.0.00..0.0.0.0.0....00.0.0.00\n"
      line_2 = "00.00.0..0..00.0000..0..00.00.0..0..00.0000..0..00.00.0..0..00.0000..0\n"
      line_3 = "....0.0.0....00.0.0.........0.0.0....00.0.0.........0.0.0....00.0.0...\n"
      line_4 = "0.0.0.0.0....00.0.0.00\n"
      line_5 = "00.00.0..0..00.0000..0\n"
      line_6 = "....0.0.0....00.0.0...\n"
      result = line_1.concat(line_2, line_3, line_4, line_5, line_6)
      
      expect(File.open(destination).read).to eq(result)
    end
    
  end
end 
