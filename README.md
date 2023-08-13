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
- Choose whether to make the code or break the code (or secret test mode)
  - If you are the code breaker: the computer sets the code and you do the fun part
  - If you are the code maker: watch the computer fail
  - In test mode, the computer plays both parts. Of course this doesn't automate the player portions. 
- You only need to type the first 3 letters of colors
 
### Coming Soon & Ideas:
- add strategies for the computer as code_breaker
- fix / finish specs


## Quirks & Bugs
N/a (I think) - except test coverage. Test coverage was started for a much earlier version. Needs reworking. 
