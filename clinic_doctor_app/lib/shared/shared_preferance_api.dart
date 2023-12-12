import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefApi {
  // static late final prefs;

  // SharedPrefApi() {
  //   prefs = SharedPreferences.getInstance();
  // }
  static set(
      {required String key, required value, required String type}) async {
// Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    switch (type) {
      case "int":
        // Save an integer value to 'counter' key.
        await prefs.setInt(key, value);
        break;
      case "bool":
        // Save an boolean value to 'repeat' key.
        await prefs.setBool(key, value);
        break;
      case "double":
        // Save an double value to 'decimal' key.
        await prefs.setDouble(key, value);
        break;
      case "string":
        // Save an String value to 'action' key.
        await prefs.setString(key, value);
        break;
      case "list":
        // Save an list of strings to 'items' key.
        await prefs.setStringList(key, value);
        break;
      default:
    }
  }

  static get({required String key, required String type}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      switch (type) {
        case "int":
          // Try reading data from the 'counter' key. If it doesn't exist, returns null.
          return prefs.getInt(key);

        case "bool":
          // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
          return prefs.getBool(key);
        case "double":
          // Try reading data from the 'decimal' key. If it doesn't exist, returns null.
          return prefs.getDouble(key);
        case "string":
          // Try reading data from the 'action' key. If it doesn't exist, returns null.
          return prefs.getString(key);

        case "list":
          // Try reading data from the 'items' key. If it doesn't exist, returns null.
          return prefs.getStringList(key);

        default:
      }
    } catch (e) {}
  }

  static delet({required String key}) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove data for the 'counter' key.
    final success = await prefs.remove(key);
    return success;
  }
}
