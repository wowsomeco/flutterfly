extension DateTimeExtensions on DateTime? {
  /// Returns the age by subtracting the current DateTime from current year.
  ///
  /// returns null if the DateTime is null.
  ///
  /// ```dart
  /// String? dateStr = '2000-10-10';
  /// int? theAge =  dateStr.toDateTime().age();
  /// ```
  int? age() {
    if (this == null) return null;

    DateTime cur = this!;
    DateTime now = DateTime.now();
    int age = now.year - cur.year;
    if (cur.month <= now.month && cur.day < now.day) {
      age--;
    }

    return age;
  }
}
