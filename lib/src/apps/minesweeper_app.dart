import 'package:flutter/material.dart';
import 'package:wt_minesweeper/src//widgets/minesweeper_score.dart';
import 'package:wt_minesweeper/src/widgets/minesweeper_grid.dart';
import 'package:wt_minesweeper/src/widgets/minesweeper_reset.dart';

class MinesweeperApp extends StatelessWidget {
  const MinesweeperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MinesweeperReset(),
        actions: const [
          MinesweeperScore(),
        ],
        title: const Text('Minesweeper'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: MinesweeperGrid(),
        ),
      ),
    );
  }
}
