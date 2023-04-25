import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelocatingPage extends StatefulWidget {

  RelocatingPage({Key? key}) : super (key: key);

  @override
  _RelocatingState createState() => _RelocatingState();
}

class _RelocatingState extends State<RelocatingPage>  {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relocating Estimator"),
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