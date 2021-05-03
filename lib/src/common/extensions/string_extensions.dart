import 'package:intl/intl.dart';

extension StringExtensions on String? {
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

  bool containsAny(String source) {
    if (this == null) return false;

    return this!.contains(RegExp(r'[' + source + r']'));
  }

  bool notContain(String pattern) {
    if (this == null) return false;

    for (int i = 0; i < this!.length; i++) {
      if (pattern.contains(this![i])) return false;
    }

    return true;
  }

  bool containsDigit() {
    if (this == null) return false;

    return this!.contains(RegExp(r'[0-9]'));
  }

  bool isDigitOnly() {
    if (this == null) return false;

    for (int i = 0; i < this!.length; i++) {
      bool isDigit = this![i].containsDigit();
      if (!isDigit) return false;
    }

    return true;
  }

  bool hasWhitespace() {
    if (this == null) return false;
    return this!.contains(' ');
  }

  bool isValidEmail() {
    if (this == null) return false;

    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this!);
  }
}
