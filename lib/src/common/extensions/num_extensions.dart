extension NumExtensions on num? {
  bool isBetween(num min, num max) {
    if (this == null) return false;

    return this! >= min && this! <= max;
  }
}
