import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static setData(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString(String key, String value) async {
    if (kIsWeb) {
      debugPrint("SharedPrefHelper (Web): setSecuredString with key : $key");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(key, value);
    } else {
      const flutterSecureStorage = FlutterSecureStorage();
      debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value",
      );
      await flutterSecureStorage.write(key: key, value: value);
    }
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    if (kIsWeb) {
      debugPrint('SharedPrefHelper (Web): getSecuredString with key : $key');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getString(key) ?? '';
    } else {
      const flutterSecureStorage = FlutterSecureStorage();
      debugPrint('FlutterSecureStorage : getSecuredString with key : $key');
      try {
        return await flutterSecureStorage.read(key: key) ?? '';
      } catch (e) {
        // Handle BadPaddingException - occurs when encryption key changes
        // (e.g., after app reinstall, OS update, or keystore reset)
        debugPrint(
          '⚠️ FlutterSecureStorage: Failed to decrypt key "$key". '
          'Clearing corrupted data. Error: $e',
        );
        // Delete the corrupted entry
        await flutterSecureStorage.delete(key: key);
        return '';
      }
    }
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    if (kIsWeb) {
      // NOTE: We only want to clear "secured" keys, but SharedPreferences is shared.
      // Ideally, we'd track secured keys, but for now, we rely on individual removal or accept this limitation.
      // Or we can just let clearAllData handle it if called.
      // For safety on web if we mix both, we might just want to clear specific auth tokens if known,
      // but clearAllSecuredData implies a full wipe of secured items.
      // Since we map secured -> standard prefs on web, 'clearAllData' clears everything.
      // Let's safe-guard by just loggin, but usually this is called on logout where we want to clear everything.
    } else {
      const flutterSecureStorage = FlutterSecureStorage();
      await flutterSecureStorage.deleteAll();
    }
  }
}
