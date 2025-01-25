import 'dart:io';

class TicTacToe {
  List<String> _board = List.generate(9, (index) => (index + 1).toString());
  String _current = 'X';
  bool _gameOver = false;

  void displayBoard() {
    print('');
    for (int i = 0; i < 9; i += 3) {
      print(' ${_board[i]} | ${_board[i + 1]} | ${_board[i + 2]} ');
      if (i < 6) {
        print('---|---|---');
      }
    }
    print('');
  }

  void next() {
    _current = _current == 'X' ? 'O' : 'X';
  }

// check if user input is valid
  bool isValidMove(int move) {
    return move >= 1 &&
        move <= 9 &&
        _board[move - 1] != 'X' &&
        _board[move - 1] != 'O';
  }

// recored the move on the board list
  void makeMove(int move) {
    if (isValidMove(move)) {
      _board[move - 1] = _current;
    } else {
      print('Invalid move! Please try again.');
    }
  }

// check if the current player has won
  bool checkWin() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == _current &&
          _board[pattern[1]] == _current &&
          _board[pattern[2]] == _current) {
        return true;
      }
    }
    return false;
  }

  bool isDraw() {
    return _board.every((cell) => cell == 'X' || cell == 'O');
  }

  void resetGame() {
    _board = List.generate(9, (index) => (index + 1).toString());
    _current = 'X';
    _gameOver = false;
  }

  void play() {
    print('Welcome to Tic Tac Toe');
    while (true) {
      displayBoard();
      print('Player $_current, enter your move (1-9): ');

      int? move;
      try {
        move = int.parse(stdin.readLineSync()!);
      } catch (e) {
        print('Invalid input. Please enter a number between 1 and 9.');
        continue;
      }

      if (isValidMove(move)) {
        makeMove(move);

        if (checkWin()) {
          displayBoard();
          print('Player $_current wins!');
          _gameOver = true;
        } else if (isDraw()) {
          displayBoard();
          print('The game is a draw!');
          _gameOver = true;
        } else {
          next();
        }
      } else {
        print('Invalid move! Please try again.');
      }

      if (_gameOver) {
        print('Do you want to play again? (y/n): ');
        String? choice = stdin.readLineSync()?.toLowerCase();
        if (choice == 'y') {
          resetGame();
        } else {
          print('Thanks for playing!');
          break;
        }
      }
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.play();
}
