import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatefulWidget {

  VideoPage({Key? key}) : super (key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>  {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helpful Videos"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    "Helpful Videos",
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green.shade700),
                    textScaleFactor: 3,
                  )),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                    height: 75,
                    color: Colors.green.shade700,
                    child: ListTile(
                      leading: InkWell(
                        onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=HG68Ymazo18')),
                        child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                      ),
                      title: Text("Interview Tips", style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)), //Option 1 stack overflow solution provided by user
                      subtitle:                     // Zimes for finding a way to using list tiles and inkwells
                      Column(                       //https://stackoverflow.com/questions/62257275/how-to-handle-right-overflowed-inside-listtile-flutter
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Top Interview Tips: Common Questions, \nNonverbal Communication & More | Indeed", style: const TextStyle(
                                  color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                  height: 75,
                  color: Colors.green.shade700,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=cM4bCDbCVbw')),
                      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                    ),
                    title: Text("Top 10 Tech Companies", style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                "Top 10 Most Valuable Tech Companies \n(2021) | Tech Vision", style: const TextStyle(
                                color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                  height: 75,
                  color: Colors.green.shade700,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=eLxA6hPaStw')),
                      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                    ),
                    title: Text("Interview Mock-Up", style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                "How to Ace Your Group Interview | Mock \nJob Interview | Indeed Career Tips", style: const TextStyle(
                                color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                  height: 75,
                  color: Colors.green.shade700,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=bQ1DovMfgxw')),
                      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                    ),
                    title: Text("Interview Q&A", style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                "6 MOST Difficult Interview Questions and\nhow to Answer Them | Professor Heather\nAustin", style: const TextStyle(
                                color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                  height: 75,
                  color: Colors.green.shade700,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=1qw5ITr3k9E')),
                      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                    ),
                    title: Text("Software Engineer Interview", style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                "Software Engineering Job Interview - Full\nMock Interview | freeCodeCamp.org", style: const TextStyle(
                                color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                  height: 75,
                  color: Colors.green.shade700,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=xpaz7nrNmXA')),
                      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                    ),
                    title: Text("Software Engineer Resume Tips", style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                "7 Tips for the Coding Resume (for Software\nEngineers) | TechLead", style: const TextStyle(
                                color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: Container(
                  height: 75,
                  color: Colors.green.shade700,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () => _launchUrl(Uri.parse('https://www.youtube.com/watch?v=6bJTEZnTT5A')),
                      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40,),
                    ),
                    title: Text("Interview Prep", style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                "Last-Minute Interview Prep! (How to Prepare\nfor an Interview in Under 10 Minutes!)", style: const TextStyle(
                                color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}