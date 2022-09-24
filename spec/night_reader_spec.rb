require "./lib/night_reader"

RSpec.describe NightReader do
  let(:night_reader) {NightReader.new(['braille.txt', 'original_message.txt'])}
  
  context 'initialize' do
    it "exists" do
      expect(night_reader).to be_a NightReader
    end
    
    it "has readable attributes" do
      expect(night_reader.braille_file).to eq('braille.txt')
      expect(night_reader.original_message_file).to eq('original_message.txt')
      expect(night_reader.contents).to eq(["0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"])
    end
  end
  
  context 'behavior' do
    it "#repl_output outputs a terminal message indicating the original
    message file name and the number of characters" do
      result = ["0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"]
      expect(night_reader.repl_output).to eq(result)
    end
  end
end