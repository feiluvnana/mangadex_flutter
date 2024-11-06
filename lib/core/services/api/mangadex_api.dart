import 'package:mangadexapi_flutter/mangadexapi_flutter.dart';

class MangadexApi {
  static final Mangadex _instance = Mangadex.create();
  MangadexApi._();
  static Mangadex get instance => _instance;
}
