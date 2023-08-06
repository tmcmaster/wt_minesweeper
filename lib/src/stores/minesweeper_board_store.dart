import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_minesweeper/src/builders/minesweeper_board_generator.dart';
import 'package:wt_minesweeper/src/models/minesweeper_board.dart';

class MinesweeperBoardStore extends StateNotifier<MinesweeperBoard> {
  static final provider = StateNotifierProvider<MinesweeperBoardStore, MinesweeperBoard>(
    (ref) => MinesweeperBoardStore(15, 0.5),
  );

  static final title = Provider.autoDispose.family<int, int>((ref, index) {
    final bombs = ref.watch(provider.select((value) => value.bombs));
    final clues = ref.watch(provider.select((value) => value.clues));

    return bombs.contains(index) ? -1 : clues[index] ?? 0;
  });

  MinesweeperBoardStore(int size, double difficulty)
      : super(MinesweeperBoardGenerator.generate(size, difficulty));

  void reset() {
    state = MinesweeperBoardGenerator.generate(
      state.size.width,
      state.difficulty,
    );
  }
}
