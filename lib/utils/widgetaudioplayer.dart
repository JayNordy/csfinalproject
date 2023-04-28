import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';


class WidgetAudioPlayer
{
  bool isPlaying = false;
  String source = "";
  String name = "";
  Icon icon = Icon(Icons.question_mark, color: Colors.red, size: 44,); //obvious init to find erros
  Icon labelIcon = Icon(Icons.question_mark, color: Colors.red, size: 44,);
  Color buttonColor = Colors.grey;
  double progress = 0;
  double volume = 0.5;
  final AudioPlayer player = AudioPlayer();
  bool needsUpdating = true;
  String seekLabel = "";

  WidgetAudioPlayer(String Name, String srcdir, Icon LabelIcon)
  {
    buttonColor = Colors.grey;
    icon = Icon(Icons.play_arrow, color: buttonColor, size: 44);
    source = srcdir;
    name = Name;
    isPlaying = false;
    volume = 0.5;

    labelIcon = LabelIcon;


    player.setReleaseMode(ReleaseMode.loop);
    player.setVolume(volume);
    setAudio();

    updateProg();

  }

  Future setAudio() async
  {
    player.setSourceAsset("audiosrc/" + source);
    player.stop();
  }

  void toggle()
  {
    needsUpdating = true;
    isPlaying = !isPlaying;
    if(isPlaying)
    {
      player.resume();
      buttonColor = Colors.white;
      icon = Icon(Icons.pause);
    }
    else
    {
      player.pause();
      buttonColor = Colors.grey;
      icon = Icon(Icons.play_arrow);
    }
    icon = Icon(icon.icon, color: buttonColor, size: 44);
  }

  void updateVolume(double newVol)
  {
    needsUpdating = true;
    volume = newVol;
    player.setVolume(volume);
  }

  void updateProg() async
  {
    needsUpdating = true;
    Duration? seek = await player!.getCurrentPosition();
    Duration? total = await player!.getDuration();
    int? seekSeconds = seek!.inSeconds % 60;
    int? seekMinutes = seek!.inMinutes;
    int? totalSeconds = total!.inSeconds % 60;
    int? totalMinutes = total!.inMinutes;

    String seekHandle = "";
    String totalHandle = "";

    if(seekSeconds < 10)
      {
        seekHandle = seekMinutes.toString() + ":0" + seekSeconds.toString();
      }
    else
      {
        seekHandle = seekMinutes.toString() + ":" + seekSeconds.toString();
      }
    if(totalSeconds < 10)
      {
        totalHandle = totalMinutes.toString() + ":0" + totalSeconds.toString();
      }
    else
      {
        totalHandle = totalMinutes.toString() + ":" + totalSeconds.toString();
      }

    seekLabel = seekHandle + "/" + totalHandle;
  }

  void userSeek(double newProg) async
  {
    needsUpdating = true;
    progress = newProg;
    player.seek((await player.getDuration())! * progress!);
    updateProg();
  }


  Widget toWidget()
  {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Center( child: Container(
          color: Colors.deepPurple,
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      IconButton(onPressed: toggle, icon: icon),
                      Column(
                        children: <Widget>[
                          Center(child: SliderTheme(data: SliderThemeData(
                              thumbColor: Colors.white,
                              activeTrackColor: Colors.white,
                              trackHeight: 10.0,
                          ),
                              child: Slider(
                                value: progress, onChanged: userSeek, min: 0, max: 1, label: seekLabel,)
                          )),
                          Text(seekLabel, style: TextStyle(color: Colors.white),),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        child: RotatedBox(quarterTurns: 3, child:
                          SliderTheme(data: SliderThemeData(
                              thumbColor: Colors.white,
                              activeTrackColor: Colors.white,

                          ),
                              child: Slider(
                                value: volume, onChanged: updateVolume, min: 0, max: 1, label: volume.toString(), )
                          ),
                        ),
                      ),
                      labelIcon,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ))
    );
  }
}