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

  @override
  Future<List<String>?> getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getStringList(key));
  }

  @override
  Future<bool> saveList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  @override
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class MemoryPref extends Pref {
  Map<String, Object> memoryMap = <String, Object>{};

  @override
  Future<String> getString(String key) {
    return Future.value(memoryMap[key] as String?);
  }

  @override
  Future<bool> saveString(String key, String value) async {
    memoryMap[key] = value;
    return Future.value(true);
  }

  @override
  Future<List<String>> getList(String key) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<bool> saveList(String key, value) {
    // TODO: implement saveList
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String key) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}

abstract class Pref {
  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);
  Future<bool> saveList(String key, List<String> value);
  Future<List<String>?> getList(String key);
  Future<bool> remove(String key);
}

class DATA_CONST {
  static const String CACHE_NEWS = "CACHE_NEWS";
  static const String CACHE_LANDPLANNING = "CACHE_LANDPLANNING";
}
