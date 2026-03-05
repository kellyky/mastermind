# mastermind

A test-driven, text-based implementation of the classic Mastermind game.

Players attempt to guess a 4-color code in 12 turns, receiving feedback in the form of black and white pegs:

- **Black peg** — correct color in the correct position
- **White peg** — correct color in the wrong position

Pegs are awarded in no particular order, requiring deduction and iteration to solve the code.

A more detailed outline of the game itself can be found [here](https://www.wikihow.com/Play-Mastermind).

## Project Structure

This project follows a conventional Ruby layout:

- `lib/` — game logic and supporting classes
- `bin/` — executable entry points
- `spec/` — RSpec test suite
- `Gemfile` — dependency management via Bundler

The implementation separates game logic, display concerns, and CLI orchestration into distinct components.

## Installation
1. Clone repository
2. Navigate to this directory
3. Run `bundle install` to install gems

```bash
git clone git@github.com:kellyky/mastermind.git
cd mastermind
bundle install
```

## Run the Game

```bash
bin/play
```

## Testing

```bash
bin/rspec
```
