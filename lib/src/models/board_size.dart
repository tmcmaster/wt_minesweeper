class BoardSize {
  final int width;
  final int height;

  BoardSize(this.width, this.height);

  int get area => width * height;
}
