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

  void nullDateSelection() {
    setState(() {
      selectedDate = returnEpoch();
      labelSelectButton = "Find Journal by Date";
    });
  }

  Widget journalToWidget() {
    List<Widget> content = [];
    for (int i = 0; i < widget.journal.getData().length; i++) {
      if (selectedDate != returnEpoch()) {
        if (isOnSameDay(widget.journal.getData()[i].timeRef, selectedDate)) {
          content.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flex(
                    direction: Axis.horizontal,
                    children: [widget.journal.getData(index: i)[0].toWidget()]),
                IconButton(
                    onPressed: () async {
                      widget.journal.getData(index: i)[0].expand();
                      nullDateSelection();
                    },
                    color: Colors.white,
                    icon: widget.journal.getData(index: i)[0].getExpand()
                        ? Icon(Icons.expand_less)
                        : Icon(Icons.expand_more)),
              ],
            ),
          );
        }
      } else {
        content.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: widget.journal.getData(index: i)[0].toWidget()),
              IconButton(
                  onPressed: () async {
                    widget.journal.getData(index: i)[0].expand();
                    nullDateSelection();
                  },
                  color: Colors.white,
                  icon: widget.journal.getData(index: i)[0].getExpand()
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more)),
            ],
          ),
        );
      }
    }
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: content.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 300, maxWidth: 300, minHeight: 65),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.green.shade700,
                    child: content[index],
                  ))),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditJournalPage(
                          journal: widget.journal,
                          entry: widget.journal.getData(index: index)[0])));
              nullDateSelection();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.green.shade700, padding: EdgeInsets.all(16)),
            child: const Icon(Icons.edit, color: Colors.white, size: 35),
          )
        ]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      addAutomaticKeepAlives: false,
    ));
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

    return WillPopScope(
      onWillPop: () async {
        widget.journal.save();
        return true; // allow pop
      },
      child: Scaffold(
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
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateJournalPage(journal: widget.journal)));
                nullDateSelection();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade700),
                        child: Text(labelSelectButton),
                        onPressed: () => _selectDate(context))),
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: ElevatedButton(
                      onPressed: () => nullDateSelection(),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade700),
                      child: const Icon(Icons.delete_forever,
                          color: Colors.white, size: 20),
                    ))
              ],
            ),
            journalToWidget()
          ],
        )),
      ),
    );
  }
}
