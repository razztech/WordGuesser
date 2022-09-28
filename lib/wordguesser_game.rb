class WordGuesserGame

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @incorect_guesses = 0
  end

  def guess(guess)
    raise ArgumentError.new(
      "Argument Error!"
    ) if guess == nil || guess == '' || !guess.match?(/[A-Za-z]/) 
    array_of_characters = guess.split('')
    array_of_characters.each { |c|
      if ((@word.include? c.downcase) && !(@guesses.include? c.downcase))
        @guesses = @guesses + c.downcase
      elsif @guesses.include? c.downcase
        return false
      elsif (!(@wrong_guesses.include? c.downcase))
        @wrong_guesses = @wrong_guesses + c.downcase
        @incorect_guesses = @incorect_guesses + 1
      else
        return false
      end
    }
      
  end

  def word_with_guesses()
    array = @word.split('')
    word_with_guesses = ""
    array.each { |c|
    if c != nil
      if (@guesses.include? c) 
        word_with_guesses = word_with_guesses + c
      else 
        word_with_guesses = word_with_guesses + '-'
      end
    end
    }
    return word_with_guesses
  end

  def check_win_or_lose() 
    if(word_with_guesses() == @word)
      return :win
    elsif (@incorect_guesses >= 7)
      return :lose
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
