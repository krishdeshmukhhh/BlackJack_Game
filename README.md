# Blackjack Game - MATLAB

A classic Blackjack card game implementation in MATLAB with graphical interface using the simpleGameEngine.

## Features

- Interactive gameplay with visual card display
- Splash screen with start button
- Hit and Stay buttons for player decisions
- Automated dealer logic (hits until score ≥ 17)
- Win/loss/tie detection with visual feedback
- Standard Blackjack scoring rules

## Requirements

- MATLAB (R2019b or later recommended)
- simpleGameEngine library
- Required sprite sheets:
  - `retro_cards.png` (16x16 sprites)
  - `splash_screen.png` (33x33 sprites)

## Installation

1. Clone this repository
2. Ensure `simpleGameEngine.m` is in your MATLAB path
3. Place the required sprite sheets in the same directory as the game file
4. Run `blackjack.m` in MATLAB

## How to Play

1. Run the script to see the splash screen
2. Click anywhere to start the game
3. You and the dealer each receive two cards
4. Click "Hit" to draw another card or "Stay" to end your turn
5. Goal: Get as close to 21 as possible without going over
6. Dealer automatically hits until reaching 17 or higher
7. Winner is determined by who has the higher score without busting

## Game Rules

- Number cards (2-10) are worth their face value
- Face cards (Jack, Queen, King) are worth 10
- Aces are worth 11 (simplified implementation)
- Player busts if score exceeds 21
- Dealer must hit on 16 and below, stay on 17 and above
