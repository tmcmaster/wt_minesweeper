import 'package:wt_minesweeper/src/models/board_size.dart';

class BoardPoint {
  final int x;
  final int y;

  BoardPoint(this.x, this.y);

  factory BoardPoint.fromIndex(int index, BoardSize size) {
    return BoardPoint(index % size.width, index ~/ size.height);
  }

  int asIndex(BoardSize size) {
    return y * size.width + x;
  }
}
