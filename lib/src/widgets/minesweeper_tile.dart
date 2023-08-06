import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_minesweeper/src/stores/minesweeper_state_store.dart';

class MinesweeperTile extends ConsumerWidget {
  const MinesweeperTile({
    super.key,
    required this.index,
    required this.onFlag,
    required this.onDig,
  });

  final int index;
  final void Function() onFlag;
  final void Function() onDig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flag = ref.watch(MinesweeperStateStore.flag(index));
    final value = ref.watch(MinesweeperStateStore.value(index));
    return GestureDetector(
      onTap: () {
        onDig();
      },
      onLongPress: () {
        onFlag();
      },
      child: ColoredBox(
        color: value == null ? Colors.orange : Colors.blue,
        child: GridTile(
          child: Center(
            child: flag
                ? const Icon(
                    Icons.flag,
                    size: 20,
                    color: Colors.white,
                  )
                : Text(
                    value == null
                        ? ''
                        : value == -1
                            ? 'B'
                            : value.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
