# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @guess = []
    @code = []
    @turns = 12
    @colors = ["R","O","Y","G","B","V"]
    #@solution = @colors.sample(4)
    @solution = []
    @current_letter_response = []
    @guess1 = []
    @guess2 = []
    @guess3 = []
    @guess4 = []
    @guess5 = []
    @guess6 = []
    @letter_conversion =
    [["R", "R🔴",1],
    ["O", "O🟠",2],
    ["Y", "Y🟡",3],
    ["G", "G🟢",4],
    ["B", "B🔵",5],
    ["V", "V🟣",6],]
    @positions =
    [[2, "●"],
    [1, "○"],
    [0, "_"],]
    #@numbers_for_letters = 
    #[["R", 1],
    #["O", 2],
    #["Y", 3],
    #["G", 4],
    #["B", 5],
    #["V", 6],]
    @all_combinations = []
  end

  def generate_combinations
    # loop through the first digit
    (1..6).each do |first|
      # loop through the second digit
      (1..6).each do |second|
        # loop through the third digit
        (1..6).each do |third|
          # loop through the fourth digit
          (1..6).each do |fourth|
            # add the combination to the array
            @all_combinations << [first, second, third, fourth]
          end
        end
      end
    end
  end


  def show_solution
    @solution_display = []
    @solution.each do |letter|
      @letter_conversion.each do |color|
        if letter == color[0]
          @solution_display.push(color[1])
        end
      end
    end
  end

  def maker_or_breaker_check
    puts "Would you like to be the Codemaker(M) or Codebreaker?(B) \n"
    
    maker_or_breaker = gets.chomp

    if maker_or_breaker.downcase == "quit" || maker_or_breaker.downcase == "q"
      puts "\nThanks for playing!\n\n"
      exit
    elsif maker_or_breaker.downcase == "m"
      @computer_role = "breaker"
      set_code
      computer_round
    elsif maker_or_breaker.downcase == "b"
      @computer_role = "maker"
      4.times { @solution.push(@colors.sample) }
      round
    else
      puts "Response not recognized. Please enter M or B"
      maker_or_breaker_check
    end
  end



  def set_code
    puts "Puzzle contains 4 boxes. To create your code for the computer to break, choose from 6 colors.
    Color choices: R🔴 O🟠 Y🟡 G🟢 B🔵 V🟣
    Example code: ROGY\n\n"
    puts "Enter your secret code:"

    code = gets.chomp

    quit_check(code)
    how_to_check(code)
    code_length_check(code)
    code_char_check(code)
    @solution = code.upcase.split('')
  end


  def letter_to_number
    @guess_as_number = []
    @guess.each do |letter|
      @letter_conversion.each do |color|
        if letter == color[0]
          @guess_as_number.push(color[2])
        end
      end
    end
  end

  def show_result
    @pos_display = []
    @current_letter_response.sort.reverse.each do |position|
      @positions.each do |pin|
        if position == pin[0]
          @pos_display.push(pin[1])
        end
      end
    end
  end

  def show_guess
    @guess_display = []
    @guess.each do |letter|
      @letter_conversion.each do |color|
        if letter == color[0]
          @guess_display.push(color[1])
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
      
      if @turns == 12;
        @guess1 = @current_letter_response
      elsif @turns == 11;
        @guess2 = @current_letter_response
      elsif @turns == 10;
        @guess3 = @current_letter_response
      end

      @turns -= 1;

      if @computer_role == "maker"
        round
      elsif @computer_role == "breaker"
        puts "\nThis is current letter response sort reverse #{@current_letter_response.sort.reverse}"
        computer_round
      end
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
      puts "\nPlease guess exactly 4 colors. Try again.\n\n"
      round
    end
  end

  def guess_char_check guess     
    if guess.chars.all? { |char| @colors.include? char.upcase } == false
      puts "\nPlease make your choice from these colors: R O Y G B V. Try again.\n\n"
      round
    end
  end

  def code_length_check code
    if code.size != 4
      puts "\nPlease choose exactly 4 colors. Try again.\n\n"
      set_code
    end
  end

  def code_char_check code     
    if code.chars.all? { |char| @colors.include? char.upcase } == false
      puts "\nPlease create your code from these colors: R O Y G B V. Try again.\n\n"
      set_code
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
    show_solution
    puts "\nThe solution is " + @solution_display.join(" ") + "\n\n"
    puts "You have run out of turns. Better luck next time!"
    play_again_check    
   end
  end

  def remove_colors
    if @guess1 == [0,0,0,0]
      @colors = @colors.map(&:clone) - ["R","O"]
    end

    if @guess2 == [0,0,0,0]
      @colors = @colors.map(&:clone) - ["Y","G"]
    end

    if @guess3 == [0,0,0,0]
      @colors = @colors.map(&:clone) - ["B","V"]
    end

    if @guess4 == [0,0,0,0]
      @colors = @colors.map(&:clone) - ["O","Y"]
    end

    if @guess5 == [0,0,0,0]
      @colors = @colors.map(&:clone) - ["G","B"]
    end

    if @guess6 == [0,0,0,0]
      @colors = @colors.map(&:clone) - ["V","R"]
    end
  end
  
  def computer_round
    puts "Computer has #{@turns} guesses left.\n"
    sleep(1)
    if @turns > 0
      if @turns == 12
        puts "Computer guesses:"
        @guess = ["R","R","O","O"]
      elsif @turns == 11
        puts "Computer guesses:"
        @guess = ["Y","Y","G","G"]
      elsif @turns == 10
        puts "Computer guesses:"
        @guess = ["B","B","V","V"]
      elsif @turns == 9
        puts "Computer guesses:"
        @guess = ["O","O","Y","Y"]
      elsif @turns == 8
        puts "Computer guesses:"
        @guess = ["G","G","B","B"]
      elsif @turns == 7
        puts "Computer guesses:"
        @guess = ["V","V","R","R"]
        # specify first 3 guesses as 1122, 3344, 5566, remove options from @all_combinations as appropriate
        # If there are all 0s, remove all combinations with either color
        # If there are all 1s, set guess as available colors
      elsif @current_letter_response != []
        puts "\nThis is the guess from the previous turn: #{@guess}"
        letter_to_number
        puts "\nThis is the guess from the previous turn in number format: #{@guess_as_number}"
        puts "\nThis is the letter response from the previous turn: #{@current_letter_response}"
                  
        puts "Computer guesses:"
        @guess = []
        4.times { @guess.push(@colors.sample) } #computer logic goes here
      end

      remove_colors
      win_check
      
   else
    show_solution
    puts "\nThe solution is " + @solution_display.join(" ") + "\n\n"
    puts "Computer has run out of turns. Human wins!"
    play_again_check    
   end
  end

  def how_to
    puts "Puzzle contains 4 boxes. The Codemaker will create a code from 
    the available 6 colors, and the Codebreaker will try to guess the code 
    within 12 turns.
    Color choices: R🔴 O🟠 Y🟡 G🟢 B🔵 V🟣
    Example code: ROGY
    
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
    @colors = ["R","O","Y","G","B","V"]
    generate_combinations
    how_to
    maker_or_breaker_check
  end 
    
   
end

game = Mastermind.new
game.start




