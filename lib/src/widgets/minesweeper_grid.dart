import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_minesweeper/src/stores/minesweeper_board_store.dart';
import 'package:wt_minesweeper/src/stores/minesweeper_state_store.dart';
import 'package:wt_minesweeper/src/widgets/minesweeper_tile.dart';

class MinesweeperGrid extends ConsumerWidget {
  const MinesweeperGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.read(MinesweeperBoardStore.provider);
    final won = ref.watch(MinesweeperStateStore.provider.select((value) => value.won));
    final notifier = ref.read(MinesweeperStateStore.provider.notifier);

    return SizedBox(
      width: board.size.width * 54.0,
      height: board.size.height * 54.0,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: board.size.width, // Number of columns in the grid
          mainAxisExtent: 50,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: board.size.width * board.size.height,
        itemBuilder: (BuildContext context, int index) {
          return MinesweeperTile(
            index: index,
            onFlag: () {
              if (won == null) {
                notifier.toggleFlag(index);
              }
            },
            onDig: () {
              if (won == null) {
                notifier.dig(index);
              }
            },
          );
        },
      ),
    );
  }
}
