import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobSearchPage extends StatefulWidget {

  JobSearchPage({Key? key}) : super (key: key);

  @override
  _JobSearchState createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearchPage>  {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Search"),
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