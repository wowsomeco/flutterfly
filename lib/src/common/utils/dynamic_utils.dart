class DynamicUtils {
  static T? tryCast<T>(dynamic v, {T? fallback}) => v is T ? v : fallback;
}
