import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// Credit to TreidevOffical on Youtube for the Guide on using the package and example code: https://www.youtube.com/watch?v=ueZbo_bQHMg
class VideoPage extends StatefulWidget {

  VideoPage({Key? key}) : super (key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>  {
  YoutubePlayerController? _controller;
  final List<String> _ids =[          //Credit to sarbagyastha for proving the package and example for making a list of video Ids: https://pub.dev/packages/youtube_player_flutter/example
    '3Q_oYDQ2whs',


  ];
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute:true,
        isLive: false,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(player: YoutubePlayer(
      controller: _controller!,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.green.shade700,
      progressColors: ProgressBarColors(
        playedColor: Colors.green.shade700,
        handleColor: Colors.green.shade700,

      ),
    ), builder: (context, player){
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube Videos"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: player,

      );
     },
    );
  }
}