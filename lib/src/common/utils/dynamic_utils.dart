class DynamicUtils {
  static T? tryCast<T>(dynamic v, {T? fallback}) => v is T ? v : fallback;

  static T? checkNull<T>(dynamic v, T? Function() ifNull,
      {T? Function()? ifNotNull}) {
    return v == null ? ifNull() : (ifNotNull != null ? ifNotNull() : null);
  }
}
