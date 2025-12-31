import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String settingsBoxName = 'settings';
  
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBoxName);
  }

  static Box get settingsBox => Hive.box(settingsBoxName);

  // Example generic generic save
  static Future<void> save(String boxName, String key, dynamic value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  // Example generic read
  static Future<dynamic> read(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key);
  }
}
