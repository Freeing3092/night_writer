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
      expect(night_reader.repl_output).to eq(nil)
    end
    
    it "#read_and_write reads braille text from the first argument and 
    translates the contents to english in the second argument" do
    destination = ('./data/original_message.txt')
    night_reader.read_and_write
    
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
    '..0.0.0.0.0....00.0.0.00..',
    '..00.00.0..0..00.0000..0..',
    '......0.0.0....00.0.0.....']
    expect(night_reader.contents).to eq(result)
    end
    
    it "#read_and_write can parse multiple lines in the txt file" do
    destination = ('./data/original_message.txt')
    night_reader = NightReader.new(['braille.txt', 'original_message.txt'])
    night_reader.read_and_write
    
    result = "hello world hello world hello world hello world "
    expect(File.open(destination).read).to eq(result)
    end
  end
end