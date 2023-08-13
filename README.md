# mastermind
A text-based game where you (or the computer) has to break a 4-color code. i.e. link Wordle but for colors. You have 12 attempts. 

- If you guess a correct color in the correct place, you get a red peg 
- If you guess a correct color in the incorrect place, you get a white peg

Pegs are awarded in no particular order, so you'll need to figure out which colors you've got right. 

For a more thorough description of gameplay and roles, check out this wikihow article [here](https://www.wikihow.com/Play-Mastermind)

## Installation
1. Clone our download the contents of this repo
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
- Test mode! The computer plays both parts. (Of course, this only tests the computer side of things 😆. I may revert this once I have test coverage in better shape)
 
Not quite a feature - you can manually edit `play_the_game.rb` to set the number of guesses to something other than 12. 

### Coming Soon & Ideas:
- accept first 3 letters of color - or something like that
- validation of user input 
- add strategies for the computer as code_breaker
- fix / finish specs


## Quirks & Bugs
- Correct input only, please and thanks 😈
  - When prompted for a 1 or 2, you need to enter 1 or 2
  - When prompted for a color, stick to those in the color bank. 


Test coverage was started for a much earlier version. Needs reworking. 
