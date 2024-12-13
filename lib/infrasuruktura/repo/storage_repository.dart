import 'package:flutter/foundation.dart';
// import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static StorageRepository? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageRepository> getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = StorageRepository._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  StorageRepository._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool>? putString(String key, String value) {
    if (_preferences == null) return null;
    debugPrint('writing $key : $value');
    return _preferences!.setString(key, value);
  }

  static Future<bool>? putList(String key, List<String> value) {
    if (_preferences == null) return null;
    debugPrint('writing $key : $value');
    return _preferences!.setStringList(key, value);
  }

  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;

    return _preferences!.getString(key) ?? defValue;
  }

  static Future<bool>? deleteString(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  static double getDouble(String key, {double defValue = 0.0}) {
    if (_preferences == null) return defValue;
    return _preferences!.getDouble(key) ?? defValue;
  }

  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;

    return _preferences!.getInt(key) ?? defValue;
  }

  static Future<bool>? putInt(String key, int value) {
    if (_preferences == null) return null;
    debugPrint('writing $key : $value');
    return _preferences!.setInt(key, value);
  }

  static Future<bool>? deleteInt(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  static List<String> getList(String key, {List<String> defValue = const []}) {
    if (_preferences == null) return List.empty(growable: true);
    return _preferences!.getStringList(key) ?? List.empty(growable: true);
  }

  static Future<bool>? putDouble(String key, double value) {
    if (_preferences == null) return null;
    debugPrint('writing $key : $value');
    return _preferences!.setDouble(key, value);
  }

  static Future<bool>? deleteDouble(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  static Future<bool>? putBool(String key, bool value) {
    if (_preferences == null) return null;
    debugPrint('writing $key : $value');
    return _preferences!.setBool(key, value);
  }

  static Future<bool>? deleteBool(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }

  // static Future<bool>? saveSelectedPrinter(Printer printer) {
  //   if (_preferences == null) return null;
  //   return _preferences!.setString('selectedPrinter', printer.name);
  // }

  // static Future<Printer?>? getSelectedPrinter() async {
  //   if (_preferences == null) return null;
  //   final selectedPrinterName = _preferences!.getString('selectedPrinter');
  //   if (selectedPrinterName == null) {
  //     return null;
  //   }
  //   final devices = await Printing.listPrinters();
  //   Printer? printer;
  //   for (final p in devices) {
  //     if (p.name == selectedPrinterName) {
  //       printer = p;
  //       break;
  //     }
  //   }
  //   if (printer != null) {
  //     return printer;
  //   } else {
  //     return null;
  //   }
  // }
}
