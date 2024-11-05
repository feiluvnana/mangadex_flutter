import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static late final Directory _dir;
  static late final SharedPreferences _prefs;
  static late final HttpClient _httpClient;

  static Future<void> initialize() async {
    _dir = await getApplicationDocumentsDirectory();
    _prefs = await SharedPreferences.getInstance();
    _httpClient = HttpClient();
  }

  static const String _spPrefix = "cache.";
  static const String _imagesPath = "/images/";

  static File? getImage(String cacheKey) {
    final path = _prefs.getString("$_spPrefix$cacheKey");
    if (path == null) return null;
    return File(path);
  }

  static Future<void> saveImage(String cacheKey, String imageUrl) async {
    try {
      final response =
          await _httpClient.getUrl(Uri.parse(imageUrl)).then((req) => req.close());
      final bytes = await response.expand((chunk) => chunk).toList();
      final filePath = "${_dir.path}$_imagesPath$cacheKey.png";
      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);
      await _prefs.setString("$_spPrefix$cacheKey", filePath);
    } catch (e) {
      print("Can't download image: $e");
    }
  }
}
