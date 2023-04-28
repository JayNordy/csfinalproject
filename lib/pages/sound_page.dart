
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/database.dart';
import '../utils/widgetaudioplayer.dart';
import 'dart:async';

class SoundsPage extends StatefulWidget {

  SoundsPage({Key? key}) : super (key: key);

  @override
  _SoundsPageState createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {
  List<WidgetAudioPlayer> players = [];
  List<Widget> displayables = [];

  DateTime loadEnd = DateTime.now().add(Duration(seconds: 10));
  Timer refreshTimer = Timer.periodic(Duration(hours: 2), (timer) { });

  void updateTimestamps()
  {
    for(int i = 0; i < players.length; i++)
      {
        if(players[i].isPlaying)
          {
            players[i].updateProg();
          }
      }
  }

  void update()
  {
    //print(widget.soundsLoaded);
    if(!refreshTimer.isActive)
    {
      refreshTimer.cancel();
      return;
    }
    if((refreshTimer.isActive)) {
      updateTimestamps();
      setState(() {
        List<Widget> holder = [];
        for (int i = 0; i < players.length; i++) {
          if (players[i].needsUpdating) {
            holder.add(players[i].toWidget());
            players[i].needsUpdating = false;
          }
          else {
            holder.add(displayables[i]);
          }
        }
        displayables = holder;
      });
    }
  }

  @override
  void initState() {

    final refreshTimer = Timer.periodic(
      const Duration(milliseconds: 100),
          (timer) {
        update();
      },
    );


    players.add(WidgetAudioPlayer("Autumn Day", "autumn.mp3", Icon(Icons.music_note, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Daydreaming Dragonflies", "dragonfly.mp3", Icon(Icons.music_note, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk One", "pep1.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Two", "pep2.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Three", "pep3.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Four", "pep4.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Five", "pep5.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Six", "pep6.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Seven", "pep7.mp3", Icon(Icons.groups, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Eight", "pep8.mp3", Icon(Icons.groups, color: Colors.white )));


    update();
    super.initState();
  }

  void killAll()
  {
    refreshTimer.cancel();
    print("consuming timer " + refreshTimer.toString());
    for(int i = 0; i < players.length; i++)
    {
      players[i].player.stop();
      players[i].needsUpdating = false;
    }
    players = [];
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          killAll();
          return true; // allow pop
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Sounds"),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
            ),
            backgroundColor: Colors.grey.shade900,
            body: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: displayables,
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}