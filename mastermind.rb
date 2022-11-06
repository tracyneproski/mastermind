# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @guess = []
    @turns = 12
    @colors = ["R","O","Y","G","B","V"]
    @solution = []
    4.times { @solution.push(@colors.sample) }
  end

  def win_check
    if @guess == @solution
      puts "You have won! Congratulations!"
      play_again_check
    else
      puts "Incorrect. Keep trying."
      @turns -= 1;
      round
    end
  end

  def play_again_check
    puts "Play again? Y or N\n"
    
    play_again = gets.chomp

    if play_again.downcase == "y"
      game = Mastermind.new
      game.start
    elsif play_again.downcase == "n"
      puts "Thanks for playing!"
      exit
    else
      puts "Response not recognized. Please enter Y or N"
      play_again_check
    end
  end

  def quit_check move
    if move.downcase == "quit" || move.downcase == "q"
      puts "The solution is #{@solution}. Thanks for playing!"
      exit
    end
  end

  def guess_length_check guess
    if guess.size != 4
      puts "Please guess exactly 4 colors. Try again."
      round
    end
  end

  def guess_char_check guess     
    if guess.chars.all? { |char| @colors.include? char.upcase } == false
      puts "Please make your choice from these colors: R O Y G B V. Try again."
      round
    end
  end

  def round
    puts "You have #{@turns} guesses left.\n"
    
    if @turns > 0
      puts "Make a guess:"
      guess = gets.chomp
      
      quit_check guess
      guess_length_check guess
      guess_char_check guess
      @guess = guess.upcase.split('')
    

      puts "#{@guess} is your guess" #this is where the little color display thing will go
      
      win_check

      
      #split string and iterate with index to check against @solution
      #print guesses with coded response (get responses and then sort)
      #output ● for correct guesses in correct position, ○ for correct guesses in 
      #incorrect position, and _ for incorrect guess
   else
    puts "You have run out of turns. Better luck next time!"
    play_again_check    
   end
  end

  def start
    puts "New Game started. Probably going to put the big instructions in here."
    round
  end 
    
   
end

game = Mastermind.new
game.start




