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

    return DateTime.now().year - this!.year;
  }
}
