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
    end
  end
end