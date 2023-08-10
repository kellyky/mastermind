# mastermind
Link Wordle but for colors. You have 12 guesses to break the 4-color code sequence. 

- If you guess a correct color in the correct place, you get a red peg 
- If you guess a correct color in the incorrect place, you get a white peg

Pegs are awarded in no particular order, so you'll need to figure out which colors you've got right. 

For a more thorough description of gameplay and roles, check out this wikihow article [here](https://www.wikihow.com/Play-Mastermind)

## Installation
1. Clone me
2. Navigate to this directory
3. Install pry `gem install 'pry-byebug'` - TODO: remove when complete

You should be ready to play!

## To Play
In your terminal, navigate to this directory and run `ruby play_the_game.rb`. Proceed as prompted. 

## Features
- Choose whether to make the code or break the code
  - If you are the code breaker: the computer sets the code and you do the fun part
  - If you are the code maker: watch the computer fail
- Inputting a color not in the bank gets added to the bank
 
Not quite a feature - you can manually edit `play_the_game.rb` to set the number of guesses to something other than 12. 

### Coming Soon & Ideas:
- difficulty levels for computer, human
  - e.g. smaller or larger color bank... hints?  
- possibly... ability to pull from larger color bank or for the code_maker (if its the human) to enter a color and have it added to the color bank
- possibly up the skill of the computer
- fix / finish specs

I may change my mind on these! 

## Quirks & Bugs
- Correct input only, please and thanks 😈
  - When prompted for a 1 or 2, you need to enter 1 or 2
  - When prompted for a color, any text you add gets added to color bank for guessing


Test coverage was started for a much earlier version. Needs reworking. 
