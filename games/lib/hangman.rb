def get_word_from_file
    dictionary = File.read "5desk.txt"
    selected_word = ""
    loop do
        selected_word = dictionary.split("\r\n").sample
        break if selected_word.length >= 5 and selected_word.length <= 12
    end
    selected_word
end


class Game
    attr_accessor :word, :allowed, :guesses, :correct, :incorrect, :images

    def initialize
        @word = get_word_from_file().downcase
        @allowed = 7
        @guesses = 0
        @correct = []
        (@word.length).times { @correct << "_"}
        @incorrect = []
        @images = ["Skeleton_1.png","Skeleton_2.png","Skeleton_3.png","Skeleton_4.png","Skeleton_5.png","Skeleton_6.png","Skeleton_7.png","Skeleton_8.png"]
    end

    def game_ended?
        if @correct.join() == @word
            return "win"
        elsif @guesses >= @allowed
            return "lose"
        else
            return "hang_game"
        end
    end

    def play_round(guess)
        word_array = @word.split("")
        if guess.length == 1
            if @word.include? (guess)
                word_array.each_with_index do |letter, index|
                    @correct[index] = letter if guess == letter
                end
            else
                @incorrect << guess
                @guesses += 1
            end
        else
            redirect "/win" if guess == @word
        end
    end
end