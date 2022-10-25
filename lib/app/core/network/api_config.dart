class ApiConfig {
  int offset;

  ApiConfig({
    this.offset = 0,
  });

  void increaseOffset(int count) {
    offset = offset + count;
  }

  void decreaseOffset(int count) {
    offset = (offset - count).isNegative ? 0 : offset - count;
  }
}
