require 'spec_helper'
require "./lib/night_writer"


RSpec.describe NightWriter do
  let(:reader_writer) {NightWriter.new}
  
  context 'initialization' do
    it "exists" do
      expect(reader_writer).to be_a NightWriter
    end
  end 
  
  context 'behavior' do
    it "invalid_num_arguments? returns false if the user provides more or less
    than 2 arguments" do
      user_input = ['message.txt', 'braille.txt', 'extra.txt']
      expect(NightWriter.invalid_num_arguments?(user_input)).to eq(true)
      
      user_input = ['message.txt']
      expect(NightWriter.invalid_num_arguments?(user_input)).to eq(true)
      
      user_input = ['message.txt', 'braille.txt']
      expect(NightWriter.invalid_num_arguments?(user_input)).to eq(false)
    end
    
    it "#file_exists? returns boolean value if the file can be found." do
      user_input = ['messagee.txt', 'braille.txt']
      allow(File).to receive(:exists?).and_return(true)
      expect(NightWriter.file_exists?(user_input)).to eq(false)
      
      user_input = ['message.txt', 'braille.txt']
      allow(File).to receive(:exists?).and_return(true)
      allow(NightWriter).to receive(:invalid_num_arguments?).and_return(false)
      expect(NightWriter.file_exists?(user_input)).to eq(true)
    end
    
  end
end 
