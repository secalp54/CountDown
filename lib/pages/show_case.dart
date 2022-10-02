import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';

class ShowCase extends StatefulWidget {
  ShowCase({Key? key, required this.setTime}) : super(key: key);
  String setTime;

  @override
  State<ShowCase> createState() => _ShowCaseState();
}

class _ShowCaseState extends State<ShowCase> {
  final CountdownController _controller = CountdownController(autoStart: true);
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  double tm = 1;
  double gecenZaman = 0;
  CircularStackEntry? circularStackEntry;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tm = double.tryParse(widget.setTime) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    print("SetTime:${widget.setTime}");

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Countdown(
                seconds: int.parse(widget.setTime),
                interval: const Duration(seconds: 1),
                onFinished: () {
                  //finish
                },
                build: (BuildContext context, double time) {
                  _chartKey.currentState?.updateData([stackGraph(time)]);
                  // _chartKey.currentState.updateData(circularStackEntry!);
                  return animatedChart(time);
                }),
          ],
        ),
      ),
    );
  }

  CircularStackEntry stackGraph(double time) {
    return CircularStackEntry([
      CircularSegmentEntry(
        //(100 - (time / tm)),
        (time / tm) * 100,
        const Color.fromARGB(255, 96, 184, 224),
        rankKey: 'remaining',
      ),
      const CircularSegmentEntry(
        //  time / tm,
        100,
        Color.fromARGB(255, 236, 150, 157),
        rankKey: 'completed',
      ),
    ], rankKey: "progress");
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String result;
    if (h < 10) {
      result = "0$h:";
    } else {
      result = "$h:";
    }
    if (m < 10) {
      result += "0$m:";
    } else {
      result += "$m:";
    }
    if (s < 10) {
      result += "0$s";
    } else {
      result += "$s";
    }

    return result;
  }

  Widget animatedChart(double time) {
    return AnimatedCircularChart(
      key: _chartKey,
      initialChartData: [stackGraph(time)],
      size: const Size(360, 360),
      chartType: CircularChartType.Radial,
      percentageValues: true,
      holeLabel: intToTimeLeft(time.toInt()),
      labelStyle: TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }
}
