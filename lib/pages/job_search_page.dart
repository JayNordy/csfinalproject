import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/database.dart';

class JobSearchPage extends StatefulWidget {

  JobSearchPage({Key? key, required this.data}) : super (key: key);
  JobData data;

  @override
  _JobSearchState createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearchPage>  {

  List<Widget> displayables = [];
  String search = "";

  @override
  void initState() {
    for(int i = 0; i < widget.data.getData().length; i++)
      {
        displayables.add(widget.data.getData(index: i)[0].toWidget());
      }

    super.initState();
  }

  void changeSearch(String newSearch)
  {
    setState(() {
      search = newSearch.toLowerCase();
      print(search);

      displayables = [];
      for (int i = 0; i < widget.data
          .getData()
          .length; i++) {
        if (widget.data.getData(index: i)[0].city.toLowerCase().startsWith(search)) {
          displayables.add(widget.data.getData(index: i)[0].toWidget());
        }
      }
    });
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
          child: Column( children:
              <Widget>[
                TextField(
                  onChanged: (String value) {
                    changeSearch(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter a City Name to Search",
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.deepPurpleAccent, width: 15)),
                    child: ListView(
                      children: displayables,
                    ),
                  ),
                ),
              ]
            )
      ),
    );
  }
}