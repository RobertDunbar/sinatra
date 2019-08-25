require "./lib/cipher.rb"
require "./lib/hangman.rb"
require "sinatra"
require "sinatra/reloader"

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
    guess = params["guess"]
    erb :hangman
end

