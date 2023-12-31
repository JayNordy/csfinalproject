
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

    players.add(WidgetAudioPlayer("Two Together", "twoTogether.mp3", Icon(Icons.favorite, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Autumn Day", "autumn.mp3", Icon(Icons.park, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Hanging Out", "hangingOut.mp3", Icon(Icons.nightlife, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Dog Days", "dogDays.mp3", Icon(Icons.sunny, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Falling Snow", "fallingSnow.mp3", Icon(Icons.snowing, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Lobby Time", "lobbyTime.mp3", Icon(Icons.hotel, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Feelin' Good", "feelinGood.mp3", Icon(Icons.face, color: Colors.white,)));
    players.add(WidgetAudioPlayer("Daydreaming Dragonflies", "dragonfly.mp3", Icon(Icons.bug_report, color: Colors.white )));

    players.add(WidgetAudioPlayer("Peptalk One", "pep1.mp3", Icon(Icons.museum, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Two", "pep2.mp3", Icon(Icons.local_fire_department, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Three", "pep3.mp3", Icon(Icons.access_time, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Four", "pep4.mp3", Icon(Icons.hotel, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Five", "pep5.mp3", Icon(Icons.wb_twilight, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Six", "pep6.mp3", Icon(Icons.stairs, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Seven", "pep7.mp3", Icon(Icons.local_hospital, color: Colors.white )));
    players.add(WidgetAudioPlayer("Peptalk Eight", "pep8.mp3", Icon(Icons.directions_run, color: Colors.white )));


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
      players[i].player.release();
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
              backgroundColor: Colors.green.shade700,
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                children: <Widget>[
                  Text("Relaxing Music", style: TextStyle(color: Colors.green.shade700, fontSize: 32),),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.green.shade700, width: 15)),
                      child: ListView(
                        children: displayables.sublist(0,7),
                      ),
                    ),
                  ),
                  Text("Motivational Speeches", style: TextStyle(color: Colors.green.shade700, fontSize: 32),),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.green.shade700, width: 15)),
                      child: ListView(
                        children: displayables.sublist(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}