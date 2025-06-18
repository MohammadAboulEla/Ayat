import 'package:hive_flutter/adapters.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SettingsBox {
  static late final Box _box;

  static Future<void> create() async {
    await Hive.initFlutter();
    WakelockPlus.enable(); //TODO: Make a button to toggle this
    _box = await Hive.openBox('settings');
  }

  static Box get instance => _box;
}