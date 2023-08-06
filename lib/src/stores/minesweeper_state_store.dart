import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_minesweeper/src/builders/minesweeper_board_generator.dart';
import 'package:wt_minesweeper/src/models/board_point.dart';
import 'package:wt_minesweeper/src/models/minesweeper_board.dart';
import 'package:wt_minesweeper/src/models/minesweeper_state.dart';
import 'package:wt_minesweeper/src/stores/minesweeper_board_store.dart';

class MinesweeperStateStore extends StateNotifier<MinesweeperState> {
  static final provider = StateNotifierProvider<MinesweeperStateStore, MinesweeperState>(
    (ref) => MinesweeperStateStore(ref),
  );

  static final flag = Provider.family<bool, int>(
    (ref, index) => ref.watch(provider.select((value) => value.flags)).contains(index),
  );

  static final value = Provider.family<int?, int>(
    (ref, index) {
      final isKnown = ref.watch(provider.select((value) => value.known)).contains(index);
      return isKnown ? ref.read(MinesweeperBoardStore.title(index)) : null;
    },
  );

  static final percentage = Provider.autoDispose<int>((ref) {
    final board = ref.read(MinesweeperBoardStore.provider);
    final known = ref.watch(provider.select((value) => value.known)).length;
    return (known / (board.size.area - board.bombs.length) * 100).toInt();
  });

  final Ref ref;

  MinesweeperStateStore(this.ref) : super(MinesweeperState());

  void reset() {
    state = MinesweeperState();
  }

  void dig(int index) {
    if (state.flags.contains(index)) return;

    final board = ref.read(MinesweeperBoardStore.provider);

    if (board.bombs.contains(index)) {
      state = state.copyWith(
        won: false,
        known: {
          index,
          ...state.known,
        },
      );
    } else if (board.clues.containsKey(index)) {
      state = state.copyWith(
        known: {
          index,
          ...state.known,
        },
      );
    } else {
      final discovered = _generateDiscovered(index, board);
      state = state.copyWith(
        known: {
          ...discovered,
          ...state.known,
        },
      );
    }

    _checkIfWon();
  }

  void _checkIfWon() {
    final board = ref.read(MinesweeperBoardStore.provider);
    final known = ref.read(provider.select((value) => value.known)).length;
    if ((known / (board.size.area - board.bombs.length) * 100).toInt() == 100) {
      state = state.copyWith(
        won: true,
      );
    }
  }

  void toggleFlag(int index) {
    if (state.known.contains(index)) return;

    if (state.flags.contains(index)) {
      removeFlag(index, skipCheck: true);
    } else {
      addFlag(index, skipCheck: true);
    }
  }

  void addFlag(int index, {bool skipCheck = false}) {
    if (!skipCheck && (state.known.contains(index) || state.flags.contains(index))) return;

    state = state.copyWith(
      flags: {
        index,
        ...state.flags,
      },
    );
  }

  void removeFlag(int index, {bool skipCheck = false}) {
    if (!skipCheck && (state.known.contains(index) || !state.flags.contains(index))) return;

    state = state.copyWith(
      flags: state.flags.where((i) => i != index).toSet(),
    );
  }

  Set<int> _generateDiscovered(int index, MinesweeperBoard board) {
    final discoveredSet = _getSurrounding(index, board, {...state.known});
    return {
      index,
      ...discoveredSet,
    };
  }

  static Set<int> _getSurrounding(int index, MinesweeperBoard board, Set<int> known) {
    final point = BoardPoint.fromIndex(index, board.size);
    final surroundingPoints = MinesweeperBoardGenerator.getSurroundingPoints(
      point,
      board.size,
      (i) => !known.contains(i),
    );
    final surroundingIndexes = surroundingPoints.map((p) => p.asIndex(board.size)).toSet();

    final localKnown = {...surroundingIndexes, ...known};
    final zeroIndexes = surroundingIndexes.where((i) => !board.clues.containsKey(i)).toSet();
    final recursiveIndexes = <int>{};
    for (final i in zeroIndexes) {
      final indexSet = _getSurrounding(i, board, localKnown);
      localKnown.addAll(indexSet);
      recursiveIndexes.addAll(indexSet);
    }

    return {
      ...surroundingIndexes,
      ...recursiveIndexes,
    };
  }
}
