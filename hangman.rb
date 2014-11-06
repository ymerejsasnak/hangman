class Hangman



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