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
In your terminal, navigate to this directory and run `ruby play_the_game.rb`. 

Proceed as prompted. 

## Features
- Choose whether to make the code or break the code
  - If you are the code breaker: the computer sets the code and you do the fun part
  - If you are the code maker: watch the computer fail
### Coming Soon:
- Computer to choose who breaks the code
- User to choose whether the computer chooses :trollface: 😆 - maybe... 
- User to select how many guesses
- Ability for the user to add colors to the color bank
- Ooh, maybe figure out how to have the computer find new colors
- Expand the color bank (i.e. allow user to enter a color not in the 'bank' and expand the bank to include it, so the computer knows to guess it) -- and/or place validations on which colors can be set - need to decide

Not quite a feature - you can manually edit `play_the_game.rb` to set the number of guesses to something other than 12. 

_Reserving the right to change my mind on any of the above._

## Quirks & Bugs
- Correct input only, please and thanks 😈
  - When prompted for a 1 or 2, you need to enter 1 or 2
  - When prompted for a color, you need to choose from existing colors. Otherwise the computer won't be able to guess. 

Test coverage was started for a much earlier version. Needs reworking. 
