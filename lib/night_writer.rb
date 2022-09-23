class NightWriter
  attr_reader :contents, :user_input
  
  # Store user input from command line.
  @user_input = ARGV

  # This method checks that exactly 2 arguments were provided.
  def self.invalid_num_arguments?(user_input)
    return false if user_input.count == 2
    puts "\nPlease provide 2 files: \nThe file to be translated and the destination file."
    true
  end
  
  # This method outputs the translated file creation details.
  def self.repl_output(user_input)
    puts "Created '#{@user_input[1]}' containing #{@contents.size} characters"
  end
  
  # This method checks if the file provided exists.
  def self.file_exists?(user_input)
    if !File.exist?("./data/#{user_input[0]}")
      puts "Please enter a valid file located in the data directory"
      false
    else
      @contents = File.open("./data/#{user_input[0]}").read
      repl_output(user_input)
      true
    end
  end
  
  # This conditional will execute the file_exists? mehtod if 2 arguments 
  # were provided
  if !invalid_num_arguments?(@user_input)
    file_exists?(@user_input)
  end
  
end