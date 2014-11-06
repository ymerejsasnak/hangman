class Hangman
	attr_accessor :right_letters, :wrong_letters
  attr_reader :dictionary, :answer_letters

  def initialize
  	@dictionary = Dictionary.new
    @answer_letters = dictionary.pick_word.split("")
    @right_letters = Array.new(answer_letters.size, "_")
    @wrong_letters = []
  end

  def display
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
    puts
  end


  def get_input
  	puts "Guess a letter"
  	input = gets.chomp
  	puts
  	puts process_input(input)
  	puts
  end

  def process_input(input)
  	if (right_letters.include? input) || (wrong_letters.include? input)
  		return "Already guessed that, choose another..."
  	elsif answer_letters.include? input
      answer_letters.each_with_index do |letter, index|
      	if input == answer_letters[index]
      		right_letters[index] = input
      	end
      end
      return "Good guess!  Keep going!"
  	else
  		wrong_letters << input
  		return "Not in this word.  Try again."
  	end
  end


  def won?
  	return answer_letters == right_letters
  end

  def lost?
  	return wrong_letters.size == 6
  end


  def game_loop
  	begin
  		display
  	  get_input
  	end until (won? || lost?)
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