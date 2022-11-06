# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @guess = []
    @turns = 12
    @colors = ["R","O","Y","G","B","V"]
    @solution = @colors.sample(4)
    #@solution = []
    #4.times { @solution.push(@colors.sample) }
    @current_guess_response = []
  end

  def win_check
    if @guess == @solution
      puts "You have won! Congratulations!"
      play_again_check
    else
      current_letter_response = [0,0,0,0]
      
      @guess.each_with_index do | letter, index |
        available_colors = @colors
        
        if available_colors.include?(letter) #has color already been evaluated

          if @solution.include?(letter) #is color in the solution anywhere


            @solution.each_with_index do | correct_letter, correct_index | #is color in correct position

              if @solution[correct_index] == letter[index]
                puts "#{correct_letter} at position #{correct_index} is correct\n\n"
                current_letter_response[correct_index] = 2
              else
                puts "#{correct_letter} at position #{correct_index} is not correct\n\n"              
              end
       


            available_colors.delete(letter)       
            end

          else
            available_colors.delete(letter)
          end

          
        else
          available_colors.delete(letter)          
        end        
      end

      print current_letter_response #.sort.reverse
      
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




