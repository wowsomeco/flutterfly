extension DateTimeExtensions on DateTime? {
  /// Returns the age by subtracting the current DateTime from [until]
  /// if [until] is null, it will be defaulted to today's date
  ///
  /// returns null if the DateTime is null.
  ///
  /// ```dart
  /// String? dateStr = '2000-10-10';
  /// int? theAge =  dateStr.toDateTime().age();
  /// ```
  int? age({DateTime? until}) {
    if (this == null) return null;

    DateTime cur = this!;
    DateTime to = until ?? DateTime.now();
    int age = to.year - cur.year;
    if (cur.month <= to.month && cur.day < to.day) {
      age--;
    }

    return age;
  }
}
