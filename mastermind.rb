# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @solution = [R,R,R,R]
    #use some kind of random situation for generating solution
    @guess = []
  end

  def win_check
    if @solution = @guess
      puts "Congratulations! You guessed it!"

      play_again_check
    end
  end
end




end