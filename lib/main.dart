import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_minesweeper/src/widgets/minesweeper_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Center(
          child: MinesweeperApp(),
        ),
      ),
    ),
  );
}
