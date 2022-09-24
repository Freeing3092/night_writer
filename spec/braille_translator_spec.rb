require 'spec_helper'
require "./lib/braille_translator"

RSpec.describe BrailleTranslator do
  let(:braille_translator) {BrailleTranslator.new}
  
  context 'initialization' do
    it "exists" do
      expect(braille_translator).to be_a BrailleTranslator
    end
    
    it "has a readable attribute with the english alphabet as keys and an
    array of 3 elements with the braille translation as values." do
      expect(braille_translator.alphabet).to be_a Hash
      expect(braille_translator.alphabet['a']).to eq(['0.', '..', '..'])
      expect(braille_translator.alphabet['z']).to eq(['0.', '.0', '00'])
      expect(braille_translator.alphabet[' ']).to eq(['..', '..', '..'])
    end
    
    it "has a readable attribute for an empty array" do
      expect(braille_translator.text_array).to eq([])
    end
  end
  
  context 'behavior' do
    it "read_and_write reads input from one file and writes it to another." do
      message = ('./data/message.txt')
      destination = ('./data/braille.txt')
      
      braille_translator.read_and_write(message, destination)
      
      result = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n"
      expect(File.open(destination).read).to eq(result)
    end
    
    it "format_text_to_array" do
      string = "Hello World Hello World Hello World Hello World "
      braille_translator.format_text_to_array(string)
      expect(braille_translator.text_array).to eq(["Hello World Hello World Hello World", " Hello World "])
    end
    
    it "read_and_write wraps text longer than 40 braille characters or
    80 regular characters." do
      message = ('./data/long_message.txt')
      destination = ('./data/braille.txt')
      
      braille_translator.read_and_write(message, destination)
      
      result = "0.0.0.0.0....00.0.0.00..0.0.0.0.0....00.0.0.00..0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0..00.00.0..0..00.0000..0..00.00.0..0..00.0000..0\n....0.0.0....00.0.0.........0.0.0....00.0.0.........0.0.0....00.0.0...\n..0.0.0.0.0....00.0.0.00..\n..00.00.0..0..00.0000..0..\n......0.0.0....00.0.0.....\n"
      expect(File.open(destination).read).to eq(result)
    end
  end
end 
