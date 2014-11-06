class Hangman
	attr_accessor :right_letters, :wrong_letters, :wrong_guesses
  attr_reader :dictionary, :answer_word

  def initialize
  	@dictionary = Dictionary.new
    @answer_letters = dictionary.pick_word.split("")
    @right_letters = Array.new(answer_word.length, "_")
    @wrong_letters = []
    @wrong_guesses = 0
  end

  def display
    puts
    puts
    puts "Wrong guesses: #{wrong_letters.join(", ")}"
    puts "Wrong guesses left: #{(6 - wrong_guesses)}"
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
  	check_input(input)
  end

  def check_input(input)
  	if (right_letters.include? input && !(wrong_letters.include? input)) 

  end

  def won?
  end

  def lost?
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
    	@word_list = file.read.split("\r\n").select {|word| (5..12) === word.length}
    end
  end

  def pick_word
  	word_list.sample
  end

end



class Player

end





game = Hangman.new