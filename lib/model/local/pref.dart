import 'package:shared_preferences/shared_preferences.dart';

class LocalPref extends Pref {
  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString(key));
  }
}

class MemoryPref extends Pref {
  Map<String, Object> memoryMap = Map<String, Object>();

  @override
  Future<String> getString(String key) {
    return Future.value(memoryMap[key] as String?);
  }

  @override
  Future<bool> saveString(String key, String value) async {
    memoryMap[key] = value;
    return Future.value(true);
  }
}

abstract class Pref {
  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);
}

class DATA_CONST {
  static const String CACHE_NEWS = "CACHE_NEWS";
  static const String CACHE_LANDPLANNING = "CACHE_LANDPLANNING";
}
