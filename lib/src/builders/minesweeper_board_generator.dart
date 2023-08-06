import 'dart:math';

import 'package:wt_minesweeper/src/models/board_point.dart';
import 'package:wt_minesweeper/src/models/board_size.dart';
import 'package:wt_minesweeper/src/models/minesweeper_board.dart';

mixin MinesweeperBoardGenerator {
  static final _random = Random();

  static MinesweeperBoard generate(int size, double difficulty) {
    final boardSize = BoardSize(size, size);
    final bombs = _generateBombs(boardSize, difficulty);
    final clues = _generateClues(boardSize, bombs);
    return MinesweeperBoard(
      size: boardSize,
      difficulty: 0.5,
      bombs: bombs,
      clues: clues,
    );
  }

  static Set<int> _generateBombs(BoardSize size, double difficulty) {
    return Iterable.generate((size.width * size.height * difficulty * 0.2).toInt())
        .map((e) => _random.nextInt(size.width * size.height))
        .toSet();
  }

  static Map<int, int> _generateClues(BoardSize size, Set<int> bombs) {
    final clues = <int, int>{};

    for (final index in bombs) {
      final bombPoint = BoardPoint.fromIndex(index, size);
      final surroundingPoints = getSurroundingThatAreNotBombs(bombPoint, size, bombs);
      for (final point in surroundingPoints) {
        final surroundingIndex = point.asIndex(size);
        clues[surroundingIndex] = (clues[surroundingIndex] ?? 0) + 1;
      }
    }

    return clues;
  }

  static List<BoardPoint> getSurroundingThatAreNotBombs(
    BoardPoint point,
    BoardSize size,
    Set<int> bombs,
  ) {
    return getSurroundingPoints(point, size, (i) => !bombs.contains(i));
  }

  static List<BoardPoint> getSurroundingPoints(
    BoardPoint point,
    BoardSize size,
    bool Function(int i) filter,
  ) {
    final x = point.x;
    final y = point.y;
    return [
      BoardPoint(x - 1, y - 1),
      BoardPoint(x, y - 1),
      BoardPoint(x + 1, y - 1),
      BoardPoint(x - 1, y),
      BoardPoint(x + 1, y),
      BoardPoint(x - 1, y + 1),
      BoardPoint(x, y + 1),
      BoardPoint(x + 1, y + 1),
    ]
        .where(
          (p) =>
              p.y >= 0 &&
              p.y <= size.height - 1 &&
              p.x >= 0 &&
              p.x <= size.width - 1 &&
              filter(p.asIndex(size)),
        )
        .toList();
  }
}
