# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @guess = []
    @turns = 12
    @colors = ["R","O","Y","G","B","V"]
    #@solution = @colors.sample(4)
    @solution = []
    4.times { @solution.push(@colors.sample) } #could be a "get.chomp" for codemaker
    @current_letter_response = []
    @color_pins =
    [["R", "R🔴"],
    ["O", "O🟠"],
    ["Y", "Y🟡"],
    ["G", "G🟢"],
    ["B", "B🔵"],
    ["V", "V🟣"],]
    @positions =
    [[2, "●"],
    [1, "○"],
    [0, "_"],]
  end


  def show_solution
    @solution_display = []
    @solution.each do |letter|
      @color_pins.each do |color|
        if letter == color[0]
          @solution_display.push(color[1])
        end
      end
    end
  end

  def show_guess
    @guess_display = []
    @guess.each do |letter|
      @color_pins.each do |color|
        if letter == color[0]
          @guess_display.push(color[1])
        end
      end
    end
  end

  def show_result
    @pos_display = []
    @current_letter_response.each do |position|
      @positions.each do |pin|
        if position == pin[0]
          @pos_display.push(pin[1])
        end
      end
    end
  end

  def color_include_check(letter)
    if @available_colors.include?(letter)
      if @solution.include?(letter)
        if @guess.count(letter) % @solution.count(letter) == 0
          @solution.each_with_index do |correct_letter, index|
            if correct_letter == letter
              @current_letter_response[index] = 1
            end
            @available_colors.delete(letter)
          end
        elsif @guess.count(letter) % @solution.count(letter) == 1
          solution_index = @solution.find_index(letter)
          @current_letter_response[solution_index] = 1
          @available_colors.delete(letter)
        end
      else
        @available_colors.delete(letter)
      end
    end
  end

  def color_position_check(letter, index)
    if @solution[index] == letter
      @current_letter_response[index] = 2
    end
  end

  def win_check
    @current_letter_response = [0,0,0,0]
    @available_colors = @colors.map(&:clone)

    if @guess == @solution
      show_guess
      puts "\n" + @guess_display.join(" ") + "      You have won! Congratulations!\n\n"
      play_again_check
    else
      @guess.each_with_index do | letter, index |
        color_include_check(letter) #has color already been evaluated this turn (formerly eval)
        color_position_check(letter, index) #is color in the correct position
      end

      show_guess
      show_result
      puts "\n" + @guess_display.join(" ") + "      " + @pos_display.join(" ") + "\n\n\n" 
      
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
      show_solution
      puts "\nThe solution is " + @solution_display.join(" ") + "    Thanks for playing!\n\n"
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
    puts "You have #{@turns} guesses left.\n"
    
    if @turns > 0
      puts "Make a guess:"
      guess = gets.chomp
      
      quit_check(guess)
      how_to_check(guess)
      guess_length_check(guess)
      guess_char_check(guess)
      @guess = guess.upcase.split('')
    
      win_check
      
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
    Type q to quit and show solution.\n\n\n"
  end


  def start
    how_to
    round
  end 
    
   
end

game = Mastermind.new
game.start




