import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create_journal_page.dart';
import 'edit_journal_page.dart';
import 'package:finalproject/utils/journal.dart';

class JournalPage extends StatefulWidget {
  JournalPage({Key? key, required this.journal}) : super(key: key);
  Journal journal;

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime selectedDate = DateTime.fromMicrosecondsSinceEpoch(0);
  String labelSelectButton = "Find Journal by Date";

  bool isOnSameDay(DateTime first, DateTime second) {
    Duration diff = first.difference(second);
    diff = diff.abs();
    if (diff.inDays <= 1) {
      return true;
    } else {
      return false;
    }
  }

  DateTime returnEpoch() {
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  void editEvent(int index) {
    print("MESSAGE" + index.toString());
  }

  void deleteLastLog() {
    //if (widget.database.getData().isNotEmpty) {
    setState(() {
      //widget.database.removeLastEvent();
      nullDateSelection();
    });
  }

  void nullDateSelection() {
    setState(() {
      selectedDate = returnEpoch();
      labelSelectButton = "Find Log by Date";
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      //Date Picker Popup
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.green.shade700,
                onPrimary: Colors.white,
                onSurface: Colors.green.shade400,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.green.shade700, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked.add(Duration(hours: 12));
          labelSelectButton =
              "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Job Journal"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                "Job Journal",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green.shade700),
                textScaleFactor: 3,
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
            child: Text('Create New Journal'),
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateJournalPage()));
              nullDateSelection();
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 47),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade700),
                    child: Text(labelSelectButton),
                    onPressed: () => _selectDate(context)),
                IconButton(onPressed: () => deleteLastLog(), icon: const Icon(Icons.delete_forever), color: Colors.green.shade700,) // Update this line
              ],
            ),
          ),
        ],
      )),
    );
  }
}
