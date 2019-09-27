class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses  

  def guess(guess)
    if guess == '' || guess == nil || !guess.match?(/[a-zA-Z]/)
      raise ArgumentError
    end
    guess.downcase!
    if @guesses.include?(guess) || @wrong_guesses.include?(guess)
      return false
    elsif @word.include? guess
      @guesses += guess
    else
      @wrong_guesses += guess
    end
    return true
  end

  def word_with_guesses
    chars = @word.split('')
    ret = ''
    chars.each do |char|
      if @guesses.include? char
        ret += char
      else
        ret += '-'
      end
    end
    ret
  end

  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
