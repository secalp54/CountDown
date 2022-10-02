
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPref extends StatefulWidget {
   AudioPref({Key? key}) : super(key: key);

  @override
  State<AudioPref> createState() => _AudioPrefState();
}

class _AudioPrefState extends State<AudioPref> {
  List<AudioPlayer> players =
      List.generate(4, (_) => AudioPlayer()..setReleaseMode(ReleaseMode.stop));

  int selectedPlayerIdx = 0;

  AudioPlayer get selectedPlayer => players[selectedPlayerIdx];

  List<StreamSubscription> streams = [];
 @override
  void initState() {
    super.initState();
    players.asMap().forEach((index, player) {
      streams.add(
        player.onPlayerComplete.listen(
          (it) => print('Player complete! toast-player-complete-$index'),),
      );
      streams.add(
        player.onSeekComplete.listen(
          (it) => print('Player complete! toast-player-complete-$index'),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(child: ElevatedButton(child: Text("bak"),onPressed: (){
      String url="https://cdn.pixabay.com/audio/2022/08/31/audio_419263fc12.mp3";
      Source sx=UrlSource(url);
   
      selectedPlayer.play(sx);
      
      
     
    },),);
  }
}

