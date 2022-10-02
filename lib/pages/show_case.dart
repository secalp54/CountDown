import 'dart:async';
import 'dart:math';

import 'package:counter_down/constant/string_const.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:wakelock/wakelock.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';

class ShowCase extends StatefulWidget {
  ShowCase({Key? key, required this.setTime}) : super(key: key);
  String setTime;

  @override
  State<ShowCase> createState() => _ShowCaseState();
}

class _ShowCaseState extends State<ShowCase> {
  final CountdownController _controller = CountdownController(autoStart: true);
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  List<AudioPlayer> players = List.generate(4, (_) => AudioPlayer()..setReleaseMode(ReleaseMode.stop));
  int selectedPlayerIdx = 0;
  AudioPlayer get selectedPlayer => players[selectedPlayerIdx];
  List<StreamSubscription> streams = [];
  String url = "https://www.chosic.com/download-audio/27950/";
  Source? sx;
  bool _light = false;
  bool _music = false;
  double tm = 1;
  double gecenZaman = 0;
  CircularStackEntry? circularStackEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tm = double.tryParse(widget.setTime) ?? 1;
    //Random r = Random();
    // sx = UrlSource(MyStrings.musicList[r.nextInt(MyStrings.musicList.length)]);
    players.asMap().forEach((index, player) {
      streams.add(
        player.onPlayerComplete.listen(
          (it) => _playMusic(),
        ),
      );
      streams.add(
        player.onSeekComplete.listen(
          (it) => print('Player complete! toast-player-complete-$index'),
        ),
      );
    });
  }

  _playMusic() {
    Random r = Random();
    sx = UrlSource(MyStrings.musicList[r.nextInt(MyStrings.musicList.length)]);
    selectedPlayer.play(sx!);
  }

  _onChangeLight() async {
    _light = !_light;
    _light ? Wakelock.enable() : Wakelock.disable();
  }

  _onChangeMusic() {
    _music = !_music;
    _music ? _playMusic() : selectedPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    print("SetTime:${widget.setTime}");
    Random r = Random();
    int i = r.nextInt(MyStrings.lottieUrl.length);

    return WillPopScope(
      onWillPop: () async {
        selectedPlayer.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Countdown(
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
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(flex: 2, child: Lottie.network(MyStrings.lottieUrl[i], repeat: true)),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _onChangeMusic();
                              });
                            },
                            icon: _music ? const Icon(Icons.play_arrow) : const Icon(Icons.play_arrow_outlined)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _onChangeLight();
                              });
                            },
                            icon: _light ? const Icon(Icons.light_mode) : const Icon(Icons.light_mode_outlined)),
                      ],
                    )),
              ],
            ),
          ),
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

    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

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
        fontSize: 42.0,
      ),
    );
  }
}
