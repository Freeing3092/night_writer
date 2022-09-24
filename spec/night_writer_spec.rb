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
  end 
  
  context 'behavior' do
    it "#repl_output " do
      expect(night_writer.repl_output).to eq(['hello world'])
    end
    
  end
end 
