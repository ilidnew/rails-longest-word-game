require 'open-uri'
require 'json'

class SpielController < ApplicationController
  def game
    @grid = generate_grid(9)
    @start_time = Time.now.to_s
  end

  def score
    @attempt = params[:guess]
    grid = params[:grid].chars
    start_time = params[:start_time].to_time
    end_time = Time.now
    @result = run_game(@attempt, grid, start_time, end_time)
  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    value = ""
    characters = *('A'..'Z')
    grid_size.times { value << characters[rand(26)] }
    return value
  end

  def run_game(attempt, grid, start_time, end_time)
    word_hash = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{attempt.downcase}").read)
    result = { score: 0 }
    result[:time] = end_time - start_time
    # the given word is not an english one
    if word_hash["found"] == false then result[:message] = "not an english word"
    # the given word is not in the grid
    elsif attempt.upcase.split("") & grid != attempt.upcase.split("") then result[:message] = "not in the grid"
      # word is valid and is in grid, score = time + word length
    else
      result[:message] = "Well done!"
      result[:score] = (attempt.length * 5) / result[:time]
    end
    return result
  end

end
