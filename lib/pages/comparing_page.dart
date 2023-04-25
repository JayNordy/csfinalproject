import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComparingPage extends StatefulWidget {

  ComparingPage({Key? key}) : super (key: key);

  @override
  _ComparingState createState() => _ComparingState();
}

class _ComparingState extends State<ComparingPage>  {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Comparison"),
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