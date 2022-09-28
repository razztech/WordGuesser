require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/wordguesser_game.rb'

class WordGuesserApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || WordGuesserGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end
  
  post '/create' do
    word = params[:word] || WordGuesserGame.get_random_word

    @game = WordGuesserGame.new(word)
    redirect '/show'
  end
  
  # Use existing methods in WordGuesserGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
    begin 
      result = @game.guess(letter)
    rescue ArgumentError
      flash[:message] = "Invalid guess."
    end
    if(result == false) 
      flash[:message] = "You have already used that letter."
    end
    redirect '/show'
  end
  
  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in WordGuesserGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  get '/show' do
    result = @game.check_win_or_lose()
    if (result == :win)
      redirect '/win'
    elsif (result == :lose)
      redirect '/lose'
    end
    erb :show 
  end
  
  get '/win' do
    if (@game.check_win_or_lose() == :play)
      redirect '/show'
    else
      flash[:message] = "You Win!"
      erb :win 
    end
  end
  
  get '/lose' do
    if (@game.check_win_or_lose() == :play)
      redirect '/show'
    else
      flash[:message] = "Sorry, you lose!"
      erb :lose
    end
  end
  
end
