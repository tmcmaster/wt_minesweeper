import 'package:wt_minesweeper/src/models/board_size.dart';

class MinesweeperBoard {
  final BoardSize size;
  final double difficulty;
  final Set<int> bombs;
  final Map<int, int> clues;

  MinesweeperBoard({
    required this.size,
    required this.difficulty,
    required this.bombs,
    required this.clues,
  });
}
