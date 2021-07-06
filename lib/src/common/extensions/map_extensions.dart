extension MapExtensions on Map {
  bool hasValue(dynamic key) => this.containsKey(key) && this[key] != null;

  /// Tries to parse a Map with the provided [key] into a list
  /// returns [fallback] if the key doesn't exist in the map OR the KVP is not of a list type
  List<T>? toList<T>(dynamic key, T Function(dynamic item) mapper,
      {List<T>? fallback}) {
    if (!this.hasValue(key)) return fallback;

    if (this[key] is List) {
      return (this[key] as List).map((item) => mapper(item)).toList();
    }

    return fallback;
  }

  T? tryCast<T>(dynamic key, T Function(dynamic item) mapper, {T? fallback}) {
    if (!this.containsKey(key)) return fallback;

    return mapper(this[key]);
  }
}
