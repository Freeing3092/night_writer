require "./lib/night_reader"

RSpec.describe NightReader do
  let(:night_reader) {NightReader.new(['braille2.txt', 'original_message.txt'])}

  context 'initialize' do
    it "exists" do
      expect(night_reader).to be_a NightReader
    end

    it "has readable attributes" do
      expect(night_reader.braille_file).to eq('braille2.txt')
      expect(night_reader.original_message_file).to eq('original_message.txt')
      expect(night_reader.contents).to eq(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0",
        "....0.0.0....00.0.0..."])
    end
    
    it "is a child of BrailleTranslator" do
      expect(NightReader.superclass).to eq(BrailleTranslator)
    end
  end

  context 'behavior' do
    
    it "#validate_input checks the user input for the correct number of arguments
    and a valid filename" do
      stub_const('Object::ARGV', ['braille.txt', 'message.txt', 'extra.txt'])
      expect(NightReader.validate_input).to eq("Please supply exactly 2 arguments")
      
      stub_const('Object::ARGV', ['message.txt'])
      expect(NightReader.validate_input).to eq("Please supply exactly 2 arguments")
      
      stub_const('Object::ARGV', ['braillee.txt', 'message.txt'])
      expect(NightReader.validate_input).to eq("Please supply a valid file")
      
      stub_const('Object::ARGV', ['braille2.txt', 'original_message.txt'])
      expect(NightReader.validate_input).to eq(nil)
    end
    
    it "#start creates an instance of NightReader if valid input is provided" do
      stub_const('Object::ARGV', ['braille.txt', 'message.txt', 'extra.txt'])
      expect(NightReader.start).to eq(nil)
      
      stub_const('Object::ARGV', ['message.txt'])
      expect(NightReader.start).to eq(nil)
      
      stub_const('Object::ARGV', ['braillee.txt', 'message.txt'])
      expect(NightReader.start).to eq(nil)
      
      stub_const('Object::ARGV', ['braille2.txt', 'original_message.txt'])
      expect(NightReader.start).to eq(nil)
    end
    
    it "#repl_output returns 'nil' after the message is printed to the
    terminal" do
      expect(night_reader.repl_output).to eq(nil)
    end
    
    it "#repl_output outputs a terminal message indicating the original
    message file name and the number of characters" do
      output = "Created 'braille.txt' containing 11 characters."
      allow(night_reader).to receive(:repl_output).and_return(output)
      expect(night_reader.repl_output).to eq(output)
    end
    
    it "#translate_braille_to_english reads braille text from the first argument and 
    translates the contents to english in the second argument" do
      destination = ('./data/original_message.txt')
      night_reader.translate_braille_to_english
      
      result = "hello world"
      expect(File.open(destination).read).to eq(result)
    end
    
    it "#delete_translated_characters deletes the first braille character
    from the contents attribute" do
      night_reader = NightReader.new(['braille.txt', 'original_message.txt'])
      night_reader.delete_translated_characters
      
      result = ['0.0.0.0....00.0.0.00..0.0.0.0.0....00.0.0.00..0.0.0.0.0....00.0.0.00',
      '.00.0..0..00.0000..0..00.00.0..0..00.0000..0..00.00.0..0..00.0000..0',
      '..0.0.0....00.0.0.........0.0.0....00.0.0.........0.0.0....00.0.0...',
      '0.0.0.0.0....00.0.0.00',
      '00.00.0..0..00.0000..0',
      '....0.0.0....00.0.0...']
      expect(night_reader.contents).to eq(result)
    end
    
    it "#translate_braille_to_english can parse multiple lines in the txt file" do
      destination = ('./data/original_message.txt')
      night_reader = NightReader.new(['braille.txt', 'original_message.txt'])
      night_reader.translate_braille_to_english
      
      result = "hello world hello world hello world hello world"
      expect(File.open(destination).read).to eq(result)
    end
    
    it "#wrap_english_output will wrap text in the output file if it is longer
    than 80 english characters" do
      destination = ('./data/long_original_message.txt')
      night_reader = NightReader.new(['long_braille.txt', 'long_original_message.txt'])
      night_reader.translate_braille_to_english
      night_reader.wrap_english_output
      
      result = ['revolution is an art that i pursue rather than a goal i expect to achieve. nor',
      'is this a source of dismay; a lost cause can be as spiritually satisfying as a',
      'victory.']
      expect(File.open(destination).read.split("\n")).to eq(result)
    end
    
    it "insert_new_lines inserts new lines at the index position of the first
    whitespace preceding the 79 index position of each line" do
      unformatted_text = File.open("./data/long_original_message.txt", 'r').read.split("\n").join(' ')
      new_line_count = unformatted_text.size / 80
      index = 0
      line_1 = "revolution is an art that i pursue rather than a goal i expect to achieve. nor\n"
      line_2 = "is this a source of dismay; a lost cause can be as spiritually satisfying as a\n"
      line_3 = "victory."
      result = line_1.concat(line_2, line_3)
      expect(night_reader.insert_new_lines(unformatted_text, new_line_count, index)).to eq(result)
    end
  end
end