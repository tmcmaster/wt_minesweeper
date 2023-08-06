import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_minesweeper/src/stores/minesweeper_state_store.dart';

class MinesweeperReset extends ConsumerWidget {
  const MinesweeperReset({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateStore = ref.read(MinesweeperStateStore.provider.notifier);
    final boardStore = ref.read(MinesweeperStateStore.provider.notifier);
    return IconButton(
      onPressed: () {
        boardStore.reset();
        stateStore.reset();
      },
      icon: const Icon(FontAwesomeIcons.arrowsRotate),
    );
  }
}
