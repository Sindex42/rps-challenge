require 'sinatra/base'
require './lib/game'
require './lib/player'
require './lib/cpu'

class Rps < Sinatra::Base
  enable :sessions

  before { @game = Game.instance }

  get '/' do
    erb :index
  end

  post '/names' do
    player_1 = Player.new(params[:player_1])
    player_2 = Cpu.new

    @game = Game.create(player_1, player_2)
    redirect '/choose-move'
  end

  get '/choose-move' do
    erb :choose_move
  end

  post '/attack' do
    @game.player_1.choose(params[:choice])
    @game.player_2.choose
    @game.play_round

    redirect '/result'
  end

  get '/result' do
    erb :result
  end

  run! if app_file == $0
end
