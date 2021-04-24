class MapUtils {
  static List<T> toList<T>(
      Map map, String key, T Function(dynamic item) mapper) {
    if (map[key] == null) return [];

    if (map[key] is List) {
      return (map[key] as List).map((item) => mapper(item)).toList();
    }

    return [];
  }
}
