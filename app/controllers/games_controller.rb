class GamesController < ApplicationController
  def new
    lettres = ('A'..'Z').to_a
    @letters = 10.times.map { lettres.sample }
  end

  def score
    @include = included?
    @english = english_word?
  end

  def included?
    word = params[:word].upcase!
    word.chars.all? do |letter|
      params[:word].count(letter) <= params[:grid].count(letter)
    end
  end

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
