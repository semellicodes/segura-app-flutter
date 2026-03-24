import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SnakeGameController extends ChangeNotifier {
  final int squaresPerRow;
  final int squaresPerCol;

  late int totalSquares;

  List<int> snakePosition = [];
  int foodPosition = 0;
  String direction = 'down';
  bool isPlaying = false;

  Timer? _timer;

  SnakeGameController({
    required this.squaresPerRow,
    required this.squaresPerCol,
  }) {
    totalSquares = squaresPerRow * squaresPerCol;
    _resetGameData();
  }

  void _resetGameData() {
    snakePosition = [45, 65, 85, 105, 125];
    direction = 'down';
    _spawnFood();
  }

  void _spawnFood() {
    foodPosition = Random().nextInt(totalSquares);
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalSquares);
    }
  }

  void startGame() {
    isPlaying = true;
    _resetGameData();
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      _updateGameTick();
    });
  }

  void stopGame() {
    _timer?.cancel();
    isPlaying = false;
    notifyListeners();
  }

  void disposeGame() {
    _timer?.cancel();
    super.dispose();
  }

  void updateDirection(String newDirection) {
    direction = newDirection;
  }

  void _updateGameTick() {
    final int head = snakePosition.last;
    int newHead = head;

    switch (direction) {
      case 'up':
        newHead = head - squaresPerRow;
        if (newHead < 0) newHead += totalSquares;
        break;
      case 'down':
        newHead = head + squaresPerRow;
        if (newHead >= totalSquares) newHead -= totalSquares;
        break;
      case 'left':
        newHead = (head % squaresPerRow == 0)
            ? head + squaresPerRow - 1
            : head - 1;
        break;
      case 'right':
        newHead = ((head + 1) % squaresPerRow == 0)
            ? head - squaresPerRow + 1
            : head + 1;
        break;
    }

    snakePosition.add(newHead);

    if (snakePosition.last == foodPosition) {
      _spawnFood();
    } else {
      snakePosition.removeAt(0);
    }

    if (_checkGameOver()) {
      stopGame();
    } else {
      notifyListeners();
    }
  }

  bool _checkGameOver() {
    for (int i = 0; i < snakePosition.length - 1; i++) {
      if (snakePosition.last == snakePosition[i]) return true;
    }
    return false;
  }
}
