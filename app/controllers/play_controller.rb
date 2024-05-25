require 'open-uri'
require 'json'

class PlayController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
  end

  def search_word
    url = "https://dictionary.lewagon.com/#{@message}"
    JSON.parse(URI.open(url).read)
  end

  def valid_word
    @message.upcase.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def score
    @message = params[:message]
    @grid = params[:grid]

    if !valid_word
      @answer = "The word: #{@message}, can’t be built out of the grid: #{@grid} ❌"
    elsif !search_word
      @answer = "The word: #{@message}, is valid according to the grid, but is not a valid English word ❌"
    else
      @answer = "The word: #{@message}, is valid according to the grid and is an English word ✅"
    end
  end

end
