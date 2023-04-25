import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text("Job Market"),
                    backgroundColor: Colors.green.shade700,
                    centerTitle: true,
                  ),
                  body: Center(
                    child: Column(
                      children: <Widget>[],
                    ),
                  ),
                )));
  }
}
