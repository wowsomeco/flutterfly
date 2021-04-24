import 'dart:io';

class ConnUtil {
  /// Checks whether you are currently online by trying to ping to the given [url]
  static Future<bool> checkConnection({String url = 'google.com'}) async {
    try {
      final result = await InternetAddress.lookup(url);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
