import 'package:hive_flutter/adapters.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SettingsBox {
  static late final Box _box;

  static Future<void> create() async {
    // initialize Hive with the path to store the data
    await Hive.initFlutter();
    _box = await Hive.openBox('settings');

    // Set default values for favorite ayas
    if (_box.get("myAyas") == null) {
      _box.put("myAyas", <int>[]);
    }

    // Set default values for keepAwake setting
    if (_box.get("keepAwake") == null) {
      _box.put("keepAwake", true);
    }

    // Enable or disable wakelock based on the keepAwake setting
    if (_box.get("keepAwake") == false) {
      WakelockPlus.disable();
    } else {
      WakelockPlus.enable();
    }
  }

  static Box get instance => _box;
}
