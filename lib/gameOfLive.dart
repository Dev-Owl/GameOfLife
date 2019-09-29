import 'dart:async';

import 'dart:math';

class GameOfLife {
  static const worldSize = 1024;
  static const rowLength = 32;
  static const cellMargin = 1;
  final _world = List<bool>(worldSize);
  final StreamController<double> _stateController = StreamController<double>();
  var _running = false;

  void toggleGame() {
    _running = !_running;
    _runTheGame();
  }

  List<bool> get world => _world;
  bool get running => _running;
  StreamController<double> get stateController => _stateController;

  void resetWorld() {
    final random = Random();
    _world.fillRange(0, worldSize, false);
    final totalSets = random.nextInt(((worldSize / 100) * 50).round());
    for (var i = 0; i < totalSets; ++i) {
      _world[random.nextInt(worldSize)] = true;
    }
  }

  Future<void> _runTheGame() async {
    while (_running) {
      await Future.delayed(Duration(milliseconds: 350));
      var newWorld = List<bool>.from(_world);
      for (var i = 0; i < worldSize; ++i) {
        //In case x cell alive do this
        var livingNeighbors = _countLivingCellsNearby(i);
        if (livingNeighbors < 2 || livingNeighbors > 3) {
          //die
          newWorld[i] = false;
        } else if (_world[i] &&
            (livingNeighbors == 2 || livingNeighbors == 3)) {
          //life
          newWorld[i] = true;
        } else if (!_world[i] && livingNeighbors == 3) {
          //life
          newWorld[i] = true;
        }
        _world[i] = newWorld[i];
      }
      _stateController.add(0);
    }
  }

  int _countLivingCellsNearby(int cellIndexToCheck) {
    final left = cellIndexToCheck % rowLength == 0
        ? cellIndexToCheck + (rowLength - 1)
        : cellIndexToCheck - 1;
    final right = (cellIndexToCheck + 1) % rowLength == 0
        ? cellIndexToCheck - (rowLength - 1)
        : cellIndexToCheck + 1;
    final top = cellIndexToCheck <= (rowLength - 1)
        ? worldSize - (rowLength - cellIndexToCheck).abs()
        : cellIndexToCheck - rowLength;
    final bottom = cellIndexToCheck >= (worldSize - rowLength)
        ? ((worldSize - rowLength) - cellIndexToCheck).abs()
        : cellIndexToCheck + rowLength;
    final topLeft = top % rowLength == 0 ? top + (rowLength - 1) : top - 1;
    final topRight =
        (top + 1) % rowLength == 0 ? top - (rowLength - 1) : top + 1;
    final bottomLeft =
        bottom % rowLength == 0 ? bottom + (rowLength - 1) : bottom - 1;
    final bottomRight =
        (bottom + 1) % rowLength == 0 ? bottom - (rowLength - 1) : bottom + 1;
    return _boolToInt(_world[left]) +
        _boolToInt(_world[right]) +
        _boolToInt(_world[top]) +
        _boolToInt(_world[bottom]) +
        _boolToInt(_world[topLeft]) +
        _boolToInt(_world[topRight]) +
        _boolToInt(_world[bottomLeft]) +
        _boolToInt(_world[bottomRight]);
  }

  int _boolToInt(bool input) {
    return input ? 1 : 0;
  }
}
