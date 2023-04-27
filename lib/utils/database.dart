import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class JobPoint {
  String city = "CITY NAME NOT PROVIDED";
  String metro = "METRO NAME NOT PROVIDED";
  int swdSalary = -1;
  int swdSalaryAdj = -1;
  int swdJobs = -1;
  int genSal = -1;
  int medianHome = -1;
  double livingCost = -1.0;
  double rentAvg = -1.0;
  double livingAndRent = -1.0;
  double purchasePower = -1.0;


  JobPoint(String City, String Metro, int SWDSal, int SWDSalADJ, int SWDJobs, int GenSal, int Home, double COL, double Rent, double COMP, double Power)
  {
    city = City;
    metro = Metro;
    swdSalary = SWDSal;
    swdSalaryAdj = SWDSalADJ;
    swdJobs = SWDJobs;
    genSal = GenSal;
    medianHome = Home;
    livingCost = COL;
    rentAvg = Rent;
    livingAndRent = COMP;
    purchasePower = Power;
  }

  void set({String? City, String? Metro, int? SWDSal, int? SWDSalADJ, int? SWDJobs, int? GenSal, int? Home, double? COL, double? Rent, double? COMP, double? Power})
  {
    if(City != null) { city = City; }
    if(Metro != null) { metro = Metro; }
    if(SWDSal != null) { swdSalary = SWDSal; }
    if(SWDSalADJ != null) { swdSalaryAdj = SWDSalADJ; }
    if(SWDJobs != null) { swdJobs = SWDJobs; }
    if(GenSal != null) { genSal = GenSal; }
    if(Home != null) { medianHome = Home; }
    if(COL != null) { livingCost = COL; }
    if(Rent != null) { rentAvg = Rent; }
    if(COMP != null) { livingAndRent = COMP; }
    if(Power != null) { purchasePower = Power; }
  }

  @override
  String toString() { //Produces a basic string representation of object
    String composite = "";

    composite += "--------------------------\n";
    composite += "\tDatapoint for City " + city.toString() + "\n";
    composite += "Metro: " + metro.toString() + "\n";
    composite += "Average Salary for a software developer in " + city.toString() + ": " + swdSalary.toString() + "\t(" + swdSalaryAdj.toString() + " adjusted) [" + swdJobs.toString() + " Jobs Avalible]\n";
    composite += "Average Salary for all occupations in " + city.toString() + ": " + genSal.toString() + "\n";
    composite += "Average home price in " + city.toString() + ": " + medianHome.toString() + "\n";
    composite += "Average rent in " + city.toString() + ": " + rentAvg.toString() + "\n";
    composite += "Average Cost of Living in " + city.toString() + ": " + livingCost.toString() + "\t(" + livingAndRent.toString() + " with rent)\n";
    composite += "Local purchasing power in " + city.toString() + ": " + purchasePower.toString() + "\n";

    composite += "=======================\n";

    return composite;
  }

  Widget toWidget() {
    return Text("database:JobCity:toWidget not yet implimented!");
  }

} //END OF CLASS SleepEvent

class JobData {

  List<JobPoint> database = []; // List containing all data via SleepEvents
  String delimeter = ",";
  String fileLocation = "";

  JobData()
  {
    print("Job Data created");
    database = [];
    _read();

  }

  void removeLastEvent() {
    if (database.isNotEmpty) {
      database.removeLast();
    }
  }

  Future<String> loadData() async { //from: https://stackoverflow.com/questions/44816042/flutter-read-text-file-from-assets
    return await rootBundle.loadString('assets/SofwareDeveloperIncomeExpensesperUSACity.csv');
  }


  _read() async {
    String text = "";
    try {

      text = await loadData();

      //print("file Content read: " + text);

      //OPEN THE FILE
      final entries = text.split('\n');
      int length = entries.length;
      //print("Entries in file: "+ length.toString());

      for(int i=0; i < length; i++) {
        if ((i > 0) && (i < length - 1)) {
          print(entries[i]);
          //print("Entry[" +i.toString() + "]: " + entries[i]);
          final line = entries[i].split('\"');
          /**
          for (int j=0; j < line.length; j++) {
            print("j[" + j.toString() + "]: " + line[j]);
          }
              **/
          final middleLine = line[2].split(',');
          /**
          print("MiddleLine.length: " + middleLine.length.toString());
          for (int j = 0; j < middleLine.length; j++) {
            print("middleLine[" + j.toString() + "]: " + middleLine[j]);
          }
              **/
          final endLine = line[4].split(',');

          String Metro = line[1];
          //print("Metro: " + Metro);
          int SWDSalADJ = double.parse(middleLine[1]).toInt();
          //print("SWDSalADJ: " + SWDSalADJ.toString());
          int SWDSal = double.parse(middleLine[2]).toInt();
          int GenSal = double.parse(middleLine[3]).toInt();
          int SWDJob = double.parse(middleLine[4]).toInt();
          int Home = double.parse(middleLine[5]).toInt();
          String City = line[3];
          double COL = double.parse(endLine[1]);
          double Rent = double.parse(endLine[2]);
          double COMP = double.parse(endLine[3]);
          //print("COMP: " + COMP.toString());
          double Power = double.parse(endLine[4]);
          //print("Power: " + Power.toString());


          /**
          String City = line[7];
          String Metro = line[1];
          int SWDSal = int.parse(line[3]);
          int SWDSalADJ = int.parse(line[2]);
          int SWDJob = int.parse(line[5]);
          int GenSal = int.parse(line[4]);
          int Home = int.parse(line[6]);
          double COL = double.parse(line[8]);
          double Rent = double.parse(line[9]);
          double COMP = double.parse(line[10]);
          double Power = double.parse(line[11]);
          **/

          addPoint(City, Metro, SWDSal, SWDSalADJ, SWDJob, GenSal, Home, COL, Rent, COMP, Power);
        }

      }
      print("Found File (_read, DATABASE) \n");
    } catch (e) {
      print("Couldn't read file (_read, DATABASE) \n");
    }
    return text;
  }

  void addPoint(String City, String Metro, int SWDSal, int SWDSalADJ, int SWDJob, int GenSal, int Home, double COL, double Rent, double COMP, double Power) //adds a sleep event at the last index of the database. A DateTime for the start of the sleep is required but other parameters are optional and will default.
  {
    database.add(JobPoint(City, Metro, SWDSal, SWDSalADJ, SWDJob, GenSal, Home, COL, Rent, COMP, Power));
  }


  JobPoint? delEvent(int index) //Deletes the event at the specified index, returning it. Returns null if no such event exists
  {
    if ((database.length - 1 < index) && (index >= 0))
    {
      return null;
    }

    JobPoint holder = database[index];
    database.removeAt(index);
    return holder;
  }

  List<JobPoint> getData({int? index}) // Returns the full database list UNLESS an index is provided as an integer, in which case a list containing just that entry is returned
  {
    if(index == null)
    {
      return database;
    }
    else
    {
      List<JobPoint> tmp = [];
      tmp.add(database[index]);
      return tmp;
    }
  }

} // END OF CLASS SleepData

void main() // test func
{
  //JobData gen = JobData(filename: "data.csv");
  //print(gen.getData()[0].toString());
}