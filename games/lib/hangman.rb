def get_word_from_file
    dictionary = File.read "../5desk.txt"
    selected_word = ""
    loop do
        selected_word = dictionary.split("\r\n").sample
        break if selected_word.length >= 5 and selected_word.length <= 12
    end
    selected_word
end


class Game
    attr_accessor :word, :allowed, :guesses, :correct, :incorrect

    def initialize
        @word = get_word_from_file()
        @allowed = 8
        @guesses = 0
        @correct = []
        (@word.length).times { @correct << "_"}
        @incorrect = []
        play_game()
    end

    def intro_game
        puts "Select 1 to start a new game or 2 to load an existing game :"
        selection = ""
        loop do
            selection = gets.chomp
            break if selection == "1" || selection == "2"
        end
        selection == "1"
    end

    def display_status
        puts "You have made #{@guesses} guesses and have a total of #{@allowed - @guesses} guesses left."
        puts "Incorrect guesses so far : #{@incorrect.join(", ")}" if @guesses > 0
        puts "Current state of mystery word : #{@correct.join(" ")}\n\n" if @guesses > 0
    end

    def player_turn
        puts "Guess a lowercase letter in the mystery word, the whole word, or type 1 to save the game and exit :"
        selection = ""
        loop do
            selection = gets.chomp
            break if /[a-z|1]/.match (selection)
        end
        selection
    end

    def winner
        puts "We have a winner. The mystery word was #{@word}!\nThanks for playing!"
        exit
    end

    def loser
        puts "We have a loser. You used all your #{@allowed} guesses. The mystery word was #{@word}!\nThanks for playing!"
        exit
    end

    def game_ended?
        @correct.join() != @word && @guesses < @allowed
    end

    def play_game
        new_game = intro_game()
        load_game() if !new_game
        while game_ended?
            display_status()
            guess = player_turn()
            save_game() if guess == "1"
            word_array = @word.split("")
            if guess.length == 1
                if @word.include? (guess)
                    word_array.each_with_index do |letter, index|
                        @correct[index] = letter if guess == letter
                    end
                else
                    @incorrect << guess
                end
            else
                winner() if guess == @word
            end
            @guesses += 1
        end
        if @correct.join() == @word
            winner()
        elsif @guesses >= @allowed
            loser()
        end
    end
end

game = Game.new