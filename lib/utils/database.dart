import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  JobData({String? filename})
  {
    database = [];

    if (filename != null) {
      fileLocation = filename;
      _read(filename);
    }
  }

  void removeLastEvent() {
    if (database.isNotEmpty) {
      database.removeLast();
    }
  }

  Future<String> _read(dir) async {
    String text = "";
    //print("READING");
    try {

      final Directory directory = await getApplicationDocumentsDirectory();

      //print(directory.toString());
      final File file = File('${directory.path}/$dir');


      text = await file.readAsString();

      //print("file Content read: " + text);

      //OPEN THE FILE
      final entries = text.split('\n');
      int length = entries.length;
      //print("Entries in file: "+ length.toString());

      for(int i=0; i < length; i++) {
        if ((i != length - 1)) {
          //print("Entry[" +i.toString() + "]: " + entries[i]);
          final line = entries[i].split(delimeter);
          /**
          int index = int.parse(line[0]);
          DateTime start = DateTime.parse(line[1]);
          DateTime end = DateTime.parse(line[2]);
          int qual = int.parse(line[3]);
          String dream = line[4];
          */
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


          addPoint(City, Metro, SWDSal, SWDSalADJ, SWDJob, GenSal, Home, COL, Rent, COMP, Power);
        }
        print("Found File (_read) \n" + '${directory.path}/$dir');
      }

    } catch (e) {
      print("Couldn't read file (_read)");
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

  void save()
  {
    String writeBuffer = "";
    int len = database.length;
    for( var i = 0 ; i < len; i++ ) {
      writeBuffer += database[i].eventNumber.toString() + delimeter;
      writeBuffer += database[i].sleep.toString() + delimeter;
      writeBuffer += database[i].wake.toString() + delimeter;
      writeBuffer += database[i].quality.toString() + delimeter;
      writeBuffer += database[i].dream.toString();
      writeBuffer += "\n";
    }
    _write(writeBuffer);
  }

  _write(String text) async { // from https://stackoverflow.com/questions/54122850/how-to-read-and-write-a-text-file-in-flutter
    await Future.delayed(const Duration( seconds: 2), () {});
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileLocation');
    await file.writeAsString(text);
    //print("saved at " + '${directory.path}/$dir');
  }


} // END OF CLASS SleepData

void main() // test func
{
  JobData gen = JobData(filename: "data.csv");
  print(gen.getData()[0].toString());
}