import 'package:shared_preferences/shared_preferences.dart';

abstract class IData {
 
    
  initFunc();
  writeDataInt(String key, int value);
  writeDataString(String key, String value);
  String readDataString(String key);
  int readDataInt(String key);
}
