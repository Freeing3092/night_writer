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
      expect(night_reader.contents).to eq(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    end
    
    it "is a child of BrailleTranslator" do
      expect(NightReader.superclass).to eq(BrailleTranslator)
    end
  end

  context 'behavior' do
    it "#repl_output outputs a terminal message indicating the original
    message file name and the number of characters" do
      expect(night_reader.repl_output).to eq(11)
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
      
      result = "hello world hello world hello worldhello world"
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
      
      result = "revolution is an art that i pursue rather than a goal i expect to achieve. nor\nis this a source of dismay; a lost cause can be as spiritually satisfying as a\nvictory."
      expect(night_reader.insert_new_lines(unformatted_text, new_line_count, index)).to eq(result)
    end
  end
end