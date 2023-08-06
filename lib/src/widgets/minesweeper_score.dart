import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_minesweeper/src/stores/minesweeper_state_store.dart';

class MinesweeperScore extends ConsumerWidget {
  const MinesweeperScore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = ref.watch(MinesweeperStateStore.percentage);
    final won = ref.watch(MinesweeperStateStore.provider.select((value) => value.won));
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          Icon(
            won == null
                ? FontAwesomeIcons.faceMeh
                : won
                    ? FontAwesomeIcons.faceGrin
                    : FontAwesomeIcons.faceSadCry,
          ),
          const SizedBox(
            width: 10,
          ),
          Text('$percentage%'),
        ],
      ),
    );
  }
}
