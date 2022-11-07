# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @guess = []
    @turns = 12
    @colors = ["R","O","Y","G","B","V"]
    @available_colors = []
    @solution = @colors.sample(4)
    #@solution = []
    #4.times { @solution.push(@colors.sample) }
    @current_letter_response = []

  end
'''
  def color_eval_check(letter)
    if @available_colors.include?(letter) == false
      next
    end
  end
'''
  def color_include_check(letter)
    if @solution.include?(letter)
      @current_letter_response[@solution.find_index(letter)] = 1
      @available_colors.delete(letter)
    else
      @available_colors.delete(letter)
    end
  end

  def color_position_check(letter, index)
    if @solution[index] == letter
      @current_letter_response[index] = 2
    end
  end

  def win_check
    if @guess == @solution
      puts "You have won! Congratulations!"
      play_again_check
    else
      @current_letter_response = [0,0,0,0]
      @available_colors = @colors

      @guess.each_with_index do | letter, index |
        #color_eval_check(letter) #has color already been evaluated this turn
        if @available_colors.include?(letter)
          color_include_check(letter) #is color in the solution anywhere             
          color_position_check(letter, index) #is color in the correct position
        end  
      end

      print @current_letter_response #.sort.reverse
      
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

  def how_to_check move
    if move.downcase == "howto"
      how_to
    end
  end

  def guess_length_check guess
    if guess.size != 4
      puts "Please guess exactly 4 colors. Try again."
      round
    end
  end

  def guess_char_check guess     
    if guess.chars.all? { |char| @colors.include? char.upcase } == "false"
      puts "Please make your choice from these colors: R O Y G B V. Try again."
      round
    end
  end

  def round
    puts "The solution is #{@solution}." #just for testing
    puts "You have #{@turns} guesses left.\n"
    
    if @turns > 0
      puts "Make a guess:"
      guess = gets.chomp
      
      quit_check guess
      how_to_check guess
      guess_length_check guess
      guess_char_check guess
      @guess = guess.upcase.split('')
    

      puts "#{@guess} is your guess" #this is where the little color display thing will go
      
      
      win_check

      

      #output ● for correct guesses in correct position, ○ for correct guesses in 
      #incorrect position, and _ for incorrect guess
   else
    puts "You have run out of turns. Better luck next time!"
    play_again_check    
   end
  end

  def how_to
    puts "Puzzle contains 4 boxes. Each turn you choose from 6 colors.
    Color choices: R🔴 O🟠 Y🟡 G🟢 B🔵 V🟣
    Example turn: ROGY
    
    Responses:
    ● : correct color in correct position
    ○ : correct color in incorrect position
    _ : incorrect color
    
    The order of the response tiles does not necessarily match the colored
    characters. 
    Type howto to read these instructions again.
    Type q to quit and show solution.\n\n"
  end


  def start
    how_to
    round
  end 
    
   
end

game = Mastermind.new
game.start




