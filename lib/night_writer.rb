class ReaderWriter
  attr_accessor :contents
  
  user_input = ARGV
  
  file_to_translate = user_input[0]
  file_path = "./data/#{file_to_translate}"
  
  if !File.exist?(file_path)
    puts "The provided file does not exist" 
  elsif user_input.count > 2
    puts "Please provide only 2 files:"
    puts "The file to be translated and the destination file."
  elsif user_input.count < 2
    puts "Please provide 2 files:"
    puts "The file to be translated and the destination file"
  end
  
  @contents = File.open(file_path).read if File.exist?(file_path)
  
  def self.repl_output(user_input)
    puts "Created '#{user_input[1]}' containing #{@contents.size} characters"
  end
   
  if File.exist?(file_path) && user_input.count == 2
    repl_output(user_input)
  end
  
end