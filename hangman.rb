class Hangman
	attr_accessor :wrong_guesses
  attr_reader :current_word, :dictionary

  def initialize
  	@dictionary = Dictionary.new
    @answer_word = dictionary.pick_word.split
    @right_letters = []
    @wrong_letters = []
    @wrong_guesses = 0
  end

  def main_display
    puts
    puts
    puts "Wrong guesses left: #{(6 - wrong_guesses)}"
    puts
    puts
    puts "Word:"
    puts
    display_word
    puts
    puts
  end

  def display_word
    current_word.each {print "_ "}
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