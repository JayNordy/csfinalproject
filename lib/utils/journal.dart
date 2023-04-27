import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:core';

class JournalEntry {
  int eventNumber = 0;
  DateTime timeRef = DateTime.now();
  String company = "";
  String impressions = "";
  String challenges = "";
  String suggestions = "";
  int quality = 0; // 1-5 scale
  bool expanding = false;

  JournalEntry(int num, DateTime ref, {String? Company, int? Quality, String? Impressions, String? Challenges, String? Suggestions})
  {
    eventNumber = num;
    timeRef = ref;
    if(Company != null)
    {
      company = Company;
    }
    if(Impressions != null)
    {
      impressions = Impressions;
    }
    if(Challenges != null)
    {
      challenges = Challenges;
    }
    if(Suggestions != null)
    {
      suggestions = Suggestions;
    }
    quality = Quality!;
  }

  void set({int? num, DateTime? Ref, String? Company, int? Quality, String? Impressions, String? Challenges, String? Suggestions}) // dynamic setter.
  {
    if(num != null)
    {
      eventNumber = num;
    }
    if(Ref != null)
    {
      timeRef = Ref;
    }
    if(Company != null)
    {
      company = Company;
    }
    if(Impressions != null)
    {
      impressions = Impressions;
    }
    if(Challenges != null)
    {
      challenges = Challenges;
    }
    if(Suggestions != null)
    {
      suggestions = Suggestions;
    }
    if((Quality != null)&&(Quality >= 0)&&(Quality <= 5))
    {

      quality = Quality;
    }
  }

  @override
  String toString() { //Produces string representation of object
    String composite = "";
    composite += "--------------------------\n";
    composite += "$company\n";
    composite += "Entry #: $eventNumber\n";
    composite += "From: $timeRef\n";
    composite += "Rating: $quality\n";
    composite += "---------------------------\n";
    composite += "Impressions: $impressions";
    composite += "---------------------------\n";
    composite += "Challenges: $challenges";
    composite += "---------------------------\n";
    composite += "Suggestions: $suggestions";
    composite += "=======================\n";

    return composite;
  }

  void expand()  {
    expanding = !expanding;
  }

  bool getExpand()  {
    return expanding;
  }

  Widget toWidget()
  {
    String viewMore = "";

    if (expanding == false)  {
      viewMore = "Click to View More Information";
    }

    if (expanding == true)  {
      viewMore = "Quality: $quality\n\nImpressions: $impressions\n\nChallenges: $challenges\n\nSuggestions: $suggestions";
    }

    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(company, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
        Text(DateFormat.MMMd().format(timeRef) + ", " + DateFormat.y().format(timeRef),
            overflow: TextOverflow.visible, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        Text(viewMore, overflow: TextOverflow.visible, style: TextStyle(color: Colors.white)),
      ],
    ));
  }
} //END OF CLASS SleepEvent

class Journal {

  List<JournalEntry> database = []; // List containing all data via SleepEvents
  String delimiter = "🂿";
  String dir = "";
  Journal({String? filename})
  {
    database = [];

    if (filename != null) {
      _read(filename);
      dir = filename;
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
          final line = entries[i].split(delimiter);
          int index = int.parse(line[0]);
          DateTime ref = DateTime.parse(line[1]);
          String company = line[2];
          int quality = int.parse(line[3]);
          String impressions = line[4];
          String challenges = line[5];
          String suggestions = line[6];
          addEvent(ref, Company: company, Quality: quality, Impressions: impressions, Challenges: challenges, Suggestions: suggestions);
        }
        //print("Found File (_read) \n" + '${directory.path}/$dir');
      }

    } catch (e) {
      print("Couldn't read file (_read)");
    }
    return text;
  }

  void addEvent(DateTime ref, {String? Company, int? Quality, String? Impressions, String? Challenges, String? Suggestions}) //adds a sleep event at the last index of the database. A DateTime for the start of the sleep is required but other parameters are optional and will default.
  {
    database.add(JournalEntry(database.length, ref, Company: Company, Quality: Quality, Impressions: Impressions, Challenges: Challenges, Suggestions: Suggestions));

  }

  JournalEntry? delEvent(int index) //Deletes the event at the specified index, returning it. Returns null if no such event exists
  {
    if ((database.length - 1 < index) && (index >= 0))
    {
      return null;
    }

    JournalEntry holder = database[index];
    database.removeAt(index);
    return holder;
  }

  int editEvent(int index, {DateTime? Ref, String? Company, int? Quality, String? Impressions, String? Challenges, String? Suggestions}) // 0 - Failure, 1 - No change, 2 - Change(s) made
  {
    if ((database.length - 1 < index) && (index >= 0)) {
      return 0; //Index is not valid
    }

    int changes = 0;

    if (Ref != null) {
      database[index].set(Ref: Ref);
      changes++;
    }
    if (Company != null) {
      database[index].set(Company: Company);
      changes++;
    }
    if (Quality != null) {
      database[index].set(Quality: Quality);
      changes++;
    }
    if (Impressions != null) {
      database[index].set(Impressions: Impressions);
      changes++;
    }
    if (Challenges != null) {
      database[index].set(Challenges: Challenges);
      changes++;
    }
    if (Suggestions != null) {
      database[index].set(Suggestions: Suggestions);
      changes++;
    }

    if (changes == 0) {
      return 1;
    }

    return 2;
  }

  List<JournalEntry> getData({int? index}) // Returns the full database list UNLESS an index is provided as an integer, in which case a list containing just that entry is returned
  {
    if(index == null)
    {
      return database;
    }
    else
    {
      List<JournalEntry> tmp = [];
      tmp.add(database[index]);
      return tmp;
    }
  }

  void save()
  {
    String writeBuffer = "";
    int len = database.length;
    for( var i = 0 ; i < len; i++ ) {
      writeBuffer += database[i].eventNumber.toString() + delimiter;
      writeBuffer += database[i].timeRef.toString() + delimiter;
      writeBuffer += database[i].company.toString() + delimiter;
      writeBuffer += database[i].quality.toString();
      writeBuffer += database[i].impressions.toString();
      writeBuffer += database[i].challenges.toString();
      writeBuffer += database[i].suggestions.toString();
      writeBuffer += "\n";
    }
    _write(writeBuffer);
  }

  _write(String text) async { // from https://stackoverflow.com/questions/54122850/how-to-read-and-write-a-text-file-in-flutter
    await Future.delayed(const Duration( seconds: 2), () {});
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$dir');
    await file.writeAsString(text);
    //print("saved at " + '${directory.path}/$dir');
  }


} // END OF CLASS SleepData

void main() // test func
{
  Journal gen = Journal(filename: "data.csv");
  gen.addEvent(DateTime.now());
  print(gen.getData()[0].toString());
}