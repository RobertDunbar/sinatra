require "sinatra"
require "sinatra/reloader"
require "./lib/cipher.rb"
require "./lib/hangman.rb"

enable :sessions

get "/" do
    erb :index
end

get "/cipher" do
    phrase = params["phrase"]
    shift = params["shift"].to_i
    encode = caesar_cipher(phrase, shift)
    erb :cipher, :locals => { :encode => encode}
end

get "/hangman" do
    erb :hangman
end

get "/hang_game" do
    session[:status] ||= Game.new
    @status = session[:status]
    @message = session.delete(:message)
    erb :hang_game
end

post "/hang_game" do
    @status = session[:status]
    @guess = params["guess"].downcase
    @status.play_round(@guess)
    @status = session[:status]
    name = @status.game_ended?
    redirect "/#{name}"
end

get "/win" do
    @status = session.delete(:status)
    erb :win
end

get "/lose" do
    @status = session.delete(:status)
    erb :lose
end


