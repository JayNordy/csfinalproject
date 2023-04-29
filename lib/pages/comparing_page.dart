import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/utils/database.dart';

class ComparingPage extends StatefulWidget {

  ComparingPage({Key? key, required this.jobData}) : super (key: key);
  JobData jobData;

  @override
  _ComparingState createState() => _ComparingState();
}

class _ComparingState extends State<ComparingPage>  {
  @override
  void initState() {
    super.initState();
  }
  List<JobPoint> database = [];
  String dropdownvalue1 = "";
  String dropdownvalue2 = "";
  bool startup = true;
  Text cityOne = Text("");
  Text cityTwo = Text("");
  Text unAdjustedOne = Text("");
  Text unAdjustedTwo = Text("");
  Text adjustedOne = Text("");
  Text adjustedTwo = Text("");
  Color boxOneColor = Colors.yellow;
  Color boxTwoColor = Colors.yellow;
  List<String> jobs = [];
  int salarayOne = 0;
  int salaryTwo = 0;
  int indexOne = 0;
  int indexTwo = 0;
  final Color evenColor = Colors.yellowAccent;
  final Color betterColor = Colors.greenAccent;
  final Color worseColor = Colors.redAccent;

  Text createText(String identifier, String info) {
    return Text(identifier + info,
      style: TextStyle(
          fontSize: 20,
          color: Colors.white
      ),
    );
  }

  List<String> databaseToStrings() {
    List<String> jobs = [];
    database = widget.jobData.getData();
    for(int i = 0; i < database.length; i++) {
      jobs.add(database[i].city);
    }


    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    jobs = databaseToStrings();
    if(startup) {
      database = widget.jobData.getData();
      dropdownvalue1 = database[0].city;
      dropdownvalue2 = dropdownvalue1;
      startup = false;
      cityOne = createText("City: ", database[0].city);
      cityTwo = cityOne;
      unAdjustedOne = createText("Unadjusted Salary: ", database[0].swdSalary.toString());
      unAdjustedTwo = unAdjustedOne;
      adjustedOne = createText("Adjusted Salary: ", database[0].swdSalaryAdj.toString());
      adjustedTwo = adjustedOne;
      salarayOne = database[0].swdSalaryAdj;
      salaryTwo = salarayOne;

    }

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
              DropdownButton<String>( //from: https://api.flutter.dev/flutter/material/DropdownButton-class.html
            value: dropdownvalue1,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownvalue1 = value!;
                indexOne = jobs.indexOf(value);
                cityOne = createText("City: ", database[indexOne].city);
                unAdjustedOne = createText("Unadjusted Salary: ", database[indexOne].swdSalary.toString());
                adjustedOne = createText("Adjusted Salary: ", database[indexOne].swdSalaryAdj.toString());
                if (database[indexOne].swdSalaryAdj > database[indexTwo].swdSalaryAdj) {
                  boxOneColor = betterColor;
                  boxTwoColor = worseColor;
                }
                if (database[indexOne].swdSalaryAdj < database[indexTwo].swdSalaryAdj) {
                  boxOneColor = worseColor;
                  boxTwoColor = betterColor;
                }
                if (database[indexOne].swdSalaryAdj == database[indexTwo].swdSalaryAdj) {
                  boxOneColor = evenColor;
                  boxTwoColor = boxOneColor;
                }



              });
            },
            items: jobs.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
              DropdownButton<String>(
                value: dropdownvalue2,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownvalue2 = value!;
                    indexTwo = jobs.indexOf(value);
                    cityTwo = createText("City: ", database[indexTwo].city);
                    unAdjustedTwo = createText("Unadjusted Salary: ", database[indexTwo].swdSalary.toString());
                    adjustedTwo = createText("Adjusted Salary: ", database[indexTwo].swdSalaryAdj.toString());
                    if (database[indexOne].swdSalaryAdj > database[indexTwo].swdSalaryAdj) {
                      boxOneColor = betterColor;
                      boxTwoColor = worseColor;
                    }
                    if (database[indexOne].swdSalaryAdj < database[indexTwo].swdSalaryAdj) {
                      boxOneColor = worseColor;
                      boxTwoColor = betterColor;
                    }
                    if (database[indexOne].swdSalaryAdj == database[indexTwo].swdSalaryAdj) {
                      boxOneColor = evenColor;
                      boxTwoColor = boxOneColor;
                    }



                  });
                },
                items: jobs.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                color: boxOneColor,
                height: 200,
                child: Column(
                  children: [
                    cityOne,
                    unAdjustedOne,
                    adjustedOne,
                  ],
                ),

              ),
              Container(
                alignment: Alignment.topLeft,
                color: boxTwoColor,
                height: 200,
                child: Column(
                  children: [
                    cityTwo,
                    unAdjustedTwo,
                    adjustedTwo,
                  ],
                ),

              ),



              /**
              Row(children: <Widget>[
                Padding(
                   padding: const EdgeInsets.only(left: 10, right: 10),
                   child: Text("[TEXT]")
    )
            ]
          )**/
          ]

      ),
          )
    );
  }
}