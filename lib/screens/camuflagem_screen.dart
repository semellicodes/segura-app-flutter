import 'package:flutter/material.dart';
import 'package:segura_app/controllers/snake_game_controller.dart';

class CamuflagemScreen extends StatefulWidget {
  const CamuflagemScreen({super.key});

  @override
  State<CamuflagemScreen> createState() => _CamuflagemScreenState();
}

class _CamuflagemScreenState extends State<CamuflagemScreen> {
  static const int _colunas = 20;
  static const int _linhas = 30;

  late final SnakeGameController _gameCtrl;

  @override
  void initState() {
    super.initState();
    _gameCtrl = SnakeGameController(
      squaresPerRow: _colunas,
      squaresPerCol: _linhas,
    );
  }

  @override
  void dispose() {
    _gameCtrl.disposeGame();
    super.dispose();
  }

  void _handleDrag(DragUpdateDetails details, {required bool checkVertical}) {
    final direcaoAtual = _gameCtrl.direction;
    if (checkVertical) {
      if (direcaoAtual != 'up' && details.delta.dy > 0) {
        _gameCtrl.updateDirection('down');
      } else if (direcaoAtual != 'down' && details.delta.dy < 0) {
        _gameCtrl.updateDirection('up');
      }
    } else {
      if (direcaoAtual != 'left' && details.delta.dx > 0) {
        _gameCtrl.updateDirection('right');
      } else if (direcaoAtual != 'right' && details.delta.dx < 0) {
        _gameCtrl.updateDirection('left');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: _buildSnakeGrid()),
                _buildStartButton(),
              ],
            ),
            _buildCloseButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSnakeGrid() {
    return Center(
      child: AspectRatio(
        aspectRatio: _colunas / _linhas,
        child: GestureDetector(
          onVerticalDragUpdate: (d) => _handleDrag(d, checkVertical: true),
          onHorizontalDragUpdate: (d) => _handleDrag(d, checkVertical: false),

          child: AnimatedBuilder(
            animation: _gameCtrl,
            builder: (context, _) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _gameCtrl.totalSquares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _colunas,
                ),
                itemBuilder: _buildGridItem,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    Color corItem;
    if (_gameCtrl.snakePosition.contains(index)) {
      corItem = Colors.green;
    } else if (index == _gameCtrl.foodPosition) {
      corItem = Colors.red;
    } else {
      corItem = Colors.grey[900]!;
    }

    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: corItem,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStartButton() {
    return AnimatedBuilder(
      animation: _gameCtrl,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ElevatedButton(
            onPressed: _gameCtrl.isPlaying ? null : _gameCtrl.startGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: _gameCtrl.isPlaying
                ? Text(
                    'Score: ${_gameCtrl.snakePosition.length - 5}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  )
                : const Text(
                    'TOCAR PARA JOGAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: 5,
      right: 5,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white30, size: 28),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
