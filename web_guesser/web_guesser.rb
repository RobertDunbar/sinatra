require "sinatra"
require "sinatra/reloader"

SECRET_NUMBER = rand(100)

get "/" do
    guess = params["guess"]
    message = check_guess(guess)
    erb :index, :locals => { :num => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
    guess_num = guess.to_i
    if guess_num == SECRET_NUMBER
        return "CORRECT guess!"
    elsif guess_num > SECRET_NUMBER + 5
        return "Guess is WAY too high!"
    elsif guess_num < SECRET_NUMBER - 5
        return "Guess is WAY too low!"
    elsif guess_num > SECRET_NUMBER
        return "Guess is too high!"
    else
        return "Guess is too low!"
    end
end