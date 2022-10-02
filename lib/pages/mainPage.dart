import 'package:counter_down/constant/string_const.dart';
import 'package:counter_down/core/Isaved_data.dart';
import 'package:counter_down/core/save_data_manager.dart';
import 'package:counter_down/pages/settings.dart';
import 'package:counter_down/pages/show_case.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class CountDownMain extends StatefulWidget {
  CountDownMain({Key? key}) : super(key: key);

  @override
  State<CountDownMain> createState() => _CountDownMainState();
}

class _CountDownMainState extends State<CountDownMain> {
  String setTime = "0";
  IData manager = DataManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTime();
    manager.initFunc();
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // ignore: unnecessary_new
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return SettingsPage();
                    },
                    fullscreenDialog: true));
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ShowCase(
              //               setTime: setTime!,
              //             )));

              Navigator.of(context).push(MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return ShowCase(
                      setTime: manager.readDataString("setTime"),
                    );
                  },
                  fullscreenDialog: true));
            },
            child: Text(MyStrings.startButtonName)),
      ),
    );
  }
}
