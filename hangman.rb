class WordHandler
    def initialize
        @words = []

        File.open("5desk.txt").each do |word|
            if word.length >= 5 && word.length <= 12
                @words << word.chomp
            end
        end
    end

    def random_word
        @words.sample
    end
end

class Play
    def initialize
        @used_letters = []
        @handler = WordHandler.new
        @word = @handler.random_word
        @current_game = ['_'] * @word.length
        @lives = @word.length+5
    end

    def lives
        @lives
    end

    def print_game # prints current game state 
        5.times do puts end
        puts "#{@lives} lives remain"
        print "Letters used:   "
        @used_letters.sort.each do |x| # prints used letters in alphaetical order
            print x + " "
        end 
        puts
        @current_game.each do |x| # prints current word
            print x            
        end
        puts
    end

    def guess_letter
        guess = ''
        success = false

        loop do # get a new letter to try
            guess = gets.chomp
            if @used_letters.include? guess
                puts "Letter already used"
            end
            break unless @used_letters.include? guess
        end

        @used_letters << guess.chomp # add input to used letters 

        @word.each_char.with_index do |x, i|
            if(x == guess.downcase || x == guess.upcase)
                @current_game[i] = guess # the successful letter gets replaced
                success = true
            end
        end

        if success == false
            @lives -= 1
        end
    end    
end

play = Play.new

loop do
    play.print_game
    play.guess_letter
    break if play.lives == 0
end