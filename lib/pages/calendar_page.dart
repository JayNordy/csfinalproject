import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {

  CalendarPage({Key? key}) : super (key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>  {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            children: <Widget>[
              //Insert the build within here
            ],
          )
      ),
    );
  }
}