import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/dsl/dsl.dart';
import 'package:wt_minesweeper/wt_minesweeper.dart';

void main() {
  runMyApp(
    asPlainApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MinesweeperApp(),
      ),
    )),
  );
}
