# Notes and scratch stuff

Puzzle contains 4 boxes. Each turn you choose from 6 colors.
Color choices: R🔴 O🟠 Y🟡 G🟢 B🔵 V🟣
Example turn: ROGY

Responses:
● : correct color in correct position
○ : correct color in incorrect position
_ : incorrect color

The order of the response tiles does not necessarily match the colored
characters. 
Type howto to read these instructions again.
Type q to quit and show solution.

Turn 1 of 10. 
Your guess: RGYB
🔴 🟢 🟡 🔵     ● ○ ○ _

Turn 2 of 10. Your guess: GYBV
🟢 🟡 🔵 🟣     ● ○ ○ _

Turn 2 of 10. Your guess: q
You chose to quit. The solution is:
🟢 🟢 🔴 🟣     ● ○ ○ _

def board_icons
  

end



colors = ["R","O","Y","G","B","V"]

def color_include_check(letter, available_colors, solution, current_letter_response)

  if available_colors.include?(letter)
    if solution.include?(letter)
      solution_index = solution.find_index(letter)
      current_letter_response[solution_index] = 1
      available_colors.delete(letter)
    else
      available_colors.delete(letter)
    end
  end
end

def color_position_check(letter, index)
  if solution[index] == letter
    current_letter_response[index] = 2
  end
end


guess.each_with_index do | letter, index |
  color_include_check(letter) #has color already been evaluated this turn (formerly eval)           
  color_position_check(letter, index) #is color in the correct position
end



def add_color(letter)
  color_pins.each do |color|
    if letter == color[0]
      guess_display.push(color[1])
    end
  end
end


def show_guess(letter)
  guess.each do |letter|
    add_color
  end
end


guess.each do |letter|
  color_pins.each do |color|
    if letter == color[0]
      guess_display.push(color[1])
    end
  end
 end