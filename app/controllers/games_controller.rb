class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].split
    @message = if guess_in_letters(@guess, @letters)
                 check_word?(@guess)
               else
                 "Sorry, #{@guess} includes letters that aren't in the grid"
               end
  end

  private

  def guess_in_letters(guess, letters)
    guess.upcase.chars.all? do |guess_letter|
      letters.include?(guess_letter)
    end
  end

  def check_word?(guess)
    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    request = URI.parse(url).open.read
    api_request = JSON.parse(request)
    api_request['found'] ? "Congrates, #{guess} is a valid word!" : "Sorry, #{guess} is not a valid word!"
  end
end
