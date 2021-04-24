import 'package:intl/intl.dart';

extension StringParsing on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String get orEmpty => this ?? "";

  /// Capitalizes a String.
  String? capitalize({String separator = ' ', String replaceWith = ' '}) {
    if (this == null) return null;

    String capitalized = '';
    List<String> splits = this!.split(separator);

    for (int i = 0; i < splits.length; i++) {
      String s = splits[i];
      capitalized += '${s[0].toUpperCase()}${s.substring(1)}';
      if (i < splits.length - 1) capitalized += replaceWith;
    }

    return capitalized;
  }

  /// Checks the intersection between 2 strings.
  bool intersects(String? other) {
    if (this == null || other == null) return false;

    for (int i = 0; i < other.length; i++) {
      String s = other[i];
      if (this!.contains(s)) return true;
    }

    return false;
  }

  String? formatDate({String fmt = 'yyyy-MM-dd'}) {
    if (this == null) return null;

    DateTime? parsed = DateTime.tryParse(this!);
    return parsed != null ? DateFormat(fmt).format(parsed) : null;
  }
}
