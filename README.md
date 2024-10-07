# Who Wants to be a Millionaire - DOS Edition

This is a simple text-based game, "Who Wants to be a Millionaire", developed using DOS Assembly (x86). The game tests your knowledge through a series of questions, where each correct answer brings you closer to becoming a "Millionaire."

## Table of Contents
- [Introduction](#introduction)
- [Gameplay](#gameplay)
- [Requirements](#requirements)
- [Installation and Execution](#installation-and-execution)
- [Code Structure](#code-structure)
- [How to Play](#how-to-play)
- [Authors](#authors)
- [License](#license)

## Introduction

This project simulates the famous quiz show *Who Wants to be a Millionaire* in a simple DOS-based environment. The game consists of nine questions, each with increasing difficulty. Answer correctly, and you could walk away with virtual winnings of up to 1 million dollars!

The game is implemented using Assembly language for the x86 architecture and relies on DOS interrupts for display, input, and game control.

## Gameplay

- The game starts with a welcome screen and asks the player to input their name.
- It displays questions one by one. Each question has four options (A, B, C, D), and the player must choose the correct answer.
- The player must answer all questions correctly to win 1 million dollars.
- There are checkpoints after certain questions, where the player can decide to forfeit and walk away with their current winnings.

## Requirements

- **Assembler**: You will need an assembler like [TASM](https://en.wikipedia.org/wiki/Turbo_Assembler) or [MASM](https://en.wikipedia.org/wiki/Microsoft_Macro_Assembler) to compile the Assembly code.
- **Emulator**: Since DOS environments are no longer commonly available, use an emulator like [DOSBox](https://www.dosbox.com/) to run the game.
  
## Installation and Execution

1. Clone or download the repository to your local machine.
2. Compile the assembly code using TASM or MASM:
    ```
    tasm millionaire.asm
    tlink millionaire.obj
    ```
3. Run the game in DOSBox or any other DOS emulator:
    ```
    millionaire.exe
    ```

## Code Structure

- **millionaire.asm**: The main source code containing the game logic, questions, and control flow.
- **questions_data.asm**: This file contains the question data and possible answers.
- **display_routines.asm**: Functions to handle text display and user input via DOS interrupts.
  
## How to Play

1. Start the game and enter your name when prompted.
2. Answer each question by typing the corresponding letter (A, B, C, or D) and pressing `Enter`.
3. Continue answering questions correctly to increase your winnings.
4. If you're unsure, you can quit and take your current earnings.

## Authors

- [Jason Miran] - Developer and Creator
- [Jiro Madrid] - Developer and Creator
- [Justin Moscoso] - Developer and Creator

