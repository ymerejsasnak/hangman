class Hangman
	attr_accessor :right_letters, :wrong_letters, :message
  attr_reader :dictionary, :answer_letters

  def initialize
  	@dictionary = Dictionary.new
    @answer_letters = dictionary.pick_word.split("")
    @right_letters = Array.new(answer_letters.size, "_")
    @wrong_letters = []
    @message = "Type 'save' at any time to save your game or 'load' to load a saved game."
  end

  def display
    puts
    puts
    puts
    puts "Wrong guesses: #{wrong_letters.join(", ")}"
    puts "Wrong guesses left: #{(6 - wrong_letters.size)}"
    puts
    puts
    puts "Word:"
    puts
    puts "#{right_letters.join(" ")}"
    puts
    puts message
    puts
    puts
  end


  def get_input
  	puts "Guess a letter"
  	input = gets.chomp.downcase
  	@message = process_input(input)
  end

  def process_input(input)
    
    if input == "save"
      return save_game
    elsif input == "load"
      return load_game
    else
      #otherwise process as a potential letter guess
      if valid_guess?(input)
       	
        if (right_letters.include? input) || (wrong_letters.include? input)
      		return "Already guessed that, choose another..."
  	  
        elsif answer_letters.include? input
          answer_letters.each_with_index do |letter, index|
          	if input == answer_letters[index]
          		right_letters[index] = input
          	end
          end
          return "Good guess!"
  	  
        else
      		wrong_letters << input
    	  	return "Not in this word."
      	end
   
      else
        return "Invalid input."
      end
    end
  end

  def valid_guess?(input)
    if input.length > 1
      return false
    else
      return /[a-z]/.match(input)
    end
  end


  def won?
  	return answer_letters == right_letters
  end

  def lost?
  	return wrong_letters.size == 6
  end

  def game_over_message
    if won?
      return "YOU WIN!"
    elsif lost?
      return "YOU LOSE!  The word was '#{answer_letters.join}.'"
    end
  end


  def game_loop
  	
    begin
  		display
  	  get_input
  	end until (won? || lost?)
    
    @message = game_over_message
    display

  end


  def save_game
    Dir.mkdir "savegames" unless Dir.exists? "savegames"
    save = gets.chomp.downcase
  end

  def load_game
    load = gets.chomp.downcase
  end

end



class Dictionary
  attr_reader :word_list

  def initialize
  	File.open("5desk.txt", "r") do |file|
    	@word_list = file.read.split("\r\n")
    	word_list.select! {|word| (5..12) === word.length}
    	word_list.reject! {|word| (/[A-Z]/) =~ word}  #cuts proper nouns out of word list
    end
  end

  def pick_word
  	word_list.sample
  end

end




game = Hangman.new
game.game_loop