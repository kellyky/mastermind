# mastermind
A text-based game where you (or the computer) has to break a 4-color code. i.e. like Wordle but for colors. You have 12 attempts.

- If you guess a correct color in the correct place, you get a red peg
- If you guess a correct color in the incorrect place, you get a white peg

Pegs are awarded in no particular order, so you'll need to figure out which colors you've got right.

For a more thorough description of gameplay and roles, check out this wikihow article [here](https://www.wikihow.com/Play-Mastermind)

## Status
Playable and enjoyable. :D

Still periodically adding test coverage and possibly features. 

## Installation
1. Clone repository
2. Navigate to this directory
3. Run `bundle install` to install gems

```bash
git clone git@github.com:kellyky/mastermind.git
cd mastermind
bundle install
```

You should be ready to play!

## To Play

```bash
bin/play
```

## Features
- Choose whether to make the code or break the code (or secret test mode)
  - If you are the code breaker: the computer sets the code and you do the fun part
  - If you are the code maker: watch the computer fail
- You only need to type the first 3 letters of colors
- Color names are printed in color

### Coming Soon (maybe!) & Ideas:
- When the computer is code breaker:
  - add strategies for the computer as code_breaker
  - re-think how the computer guesses appear to the player - either omit or slow them down to be more observable in what would feel real-time to a human player

## Quirks & Bugs
No known bugs.
