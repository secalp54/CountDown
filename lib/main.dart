import 'package:counter_down/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async {
  
   return runApp(CountDown());
}

class CountDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountDownMain(),
    );
  }
}
