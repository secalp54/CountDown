import 'package:counter_down/core/Isaved_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager extends IData {
  // final Future<SharedPreferences> _prefs;
  //final Future<SharedPreferences> _prefs;
  late SharedPreferences prefs;
  //
   initFunc() async {
    prefs = await SharedPreferences.getInstance();
  
  }

  
  @override
  writeDataInt(String key, int value) async {
    
    await prefs.setInt(key, value);
  }

  @override
  writeDataString(String key, String value) async {
    
    await prefs.setString(key, value);
  }

  @override
  int readDataInt(String key) {
    
    return prefs.getInt(key) ?? 0;
  }

  @override
  String readDataString(String key) {
    return prefs.getString(key) ?? "20";
  }
}
