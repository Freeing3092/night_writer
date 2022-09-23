require 'spec_helper'

RSpec.describe ReaderWriter do
  let(:reader_writer) {ReaderWriter.new}
  
  context 'initialization' do
    it "exists" do
      expect(reader_writer).to be_a ReaderWriter
    end
  end 
  
  context 'behavior' do
    it "#repl_output returns the name of the second file provided by the user" do
      file_path = './data/message.txt'
      allow(reader_writer).to receive(:contents).and_return(file_path)
      file = File.open(reader_writer.contents)
      expect(file.read).to eq('Hello World')
    end
    
  end
end 
