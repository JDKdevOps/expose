import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences localDB;

  static Future<void> initDB() async {
    localDB = await SharedPreferences.getInstance();
  }
}
