# mastermind
A text-based game where you (or the computer) has to break a 4-color code. i.e. like Wordle but for colors. You have 12 attempts.

- If you guess a correct color in the correct place, you get a black peg
- If you guess a correct color in the incorrect place, you get a white peg

Pegs are awarded in no particular order, so you'll need to figure out which colors you've got right.

For a more thorough description of gameplay and roles, check out this wikihow article [here](https://www.wikihow.com/Play-Mastermind)

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

## Known Issues

Scoring needs fixing.

