class BrailleTranslator
  attr_reader :alphabet
  
  def initialize
    @alphabet = {'a' => ['0.', '..', '..'],
                'z' => ['0.', '.0', '00'],
                ' ' => ['..', '..', '..']
    }
  end
end