# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.

class Mastermind
  
  def initialize
    @solution = [R,R,R,R]
    #use some kind of random situation for generating solution
    @guess = []
  end

  def round
    #get new guess
    #split string and iterate with index to check against @solution
    #print guesses with coded response (get responses and then sort)
    #output ● for correct guesses in correct position, ○ for correct guesses in 
    #incorrect position, and _ for incorrect guess
    
  end

  def begin
    puts "New Game started. Probably going to put the big instructions in here."
    puts "Make your first guess:" #explain guess format

    round
  end 
    
   
end




game = Mastermind.new
game.begin




