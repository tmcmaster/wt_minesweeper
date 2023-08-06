class MinesweeperState {
  final bool? won;
  final Set<int> flags;
  final Set<int> known;

  MinesweeperState({
    this.flags = const {},
    this.known = const {},
    this.won,
  });

  MinesweeperState copyWith({
    Set<int>? flags,
    Set<int>? known,
    bool? won,
  }) {
    return MinesweeperState(
      flags: flags ?? this.flags,
      known: known ?? this.known,
      won: won ?? this.won,
    );
  }
}
