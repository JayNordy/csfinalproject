import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:finalproject/utils/journal.dart';

class EditJournalPage extends StatefulWidget {

  EditJournalPage({Key? key, required this.journal, required this.entry}) : super (key: key);
  Journal journal;
  JournalEntry entry;

  @override
  _EditJournalPageState createState() => _EditJournalPageState();
}

class _EditJournalPageState extends State<EditJournalPage> {
  @override
  void initState() {
    super.initState();
    company.text = widget.entry.company;
    impressions.text = widget.entry.impressions;
    challenges.text = widget.entry.challenges;
    suggestions.text = widget.entry.suggestions;
    labelSelectDate = "${widget.entry.timeRef.month}/${widget.entry.timeRef.day}/${widget.entry.timeRef.year}";
    tempRate = widget.entry.quality.toDouble();
  }
  bool check1 = false;
  bool check2 = false;
  double tempRate = 0;

  var company = TextEditingController();
  var impressions = TextEditingController();
  var challenges = TextEditingController();
  var suggestions = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double rating = 0;

  String labelSelectDate = "Select a Date";

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
          selectedDate = picked;
          labelSelectDate =
          "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
        });
      }
    }

    _editJournal(DateTime selectedDate, var company, double rating, var impressions, var challenges, var suggestions) async {
      if(check1 && check2) {
        widget.journal.editEvent(widget.entry.eventNumber, Ref: selectedDate,
            Company: company.text,
            Quality: rating.toInt(),
            Impressions: impressions.text,
            Challenges: challenges.text,
            Suggestions: suggestions.text);
        widget.journal.save();
        Navigator.pop(context);
      }
      else if(!check1 && check2)  {
        widget.journal.editEvent(widget.entry.eventNumber, Ref: widget.entry.timeRef,
            Company: company.text,
            Quality: rating.toInt(),
            Impressions: impressions.text,
            Challenges: challenges.text,
            Suggestions: suggestions.text);
        widget.journal.save();
        Navigator.pop(context);
      }
      else if(check1 && !check2)  {
        widget.journal.editEvent(widget.entry.eventNumber, Ref: selectedDate,
            Company: company.text,
            Quality: widget.entry.quality,
            Impressions: impressions.text,
            Challenges: challenges.text,
            Suggestions: suggestions.text);
        widget.journal.save();
        Navigator.pop(context);
      }
      else if(!check1 && !check2)  {
        widget.journal.editEvent(widget.entry.eventNumber, Ref: widget.entry.timeRef,
            Company: company.text,
            Quality: widget.entry.quality,
            Impressions: impressions.text,
            Challenges: challenges.text,
            Suggestions: suggestions.text);
        widget.journal.save();
        Navigator.pop(context);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Journal"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    "Edit Job Journal",
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green.shade700),
                    textScaleFactor: 3,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
                    child: Text(labelSelectDate),
                    onPressed: () {
                      _selectDate(context);
                      check1 = true;
                    }),
              ),

              Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 110.0, right: 110.0,),
                  child: TextField(
                    maxLength: 20,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade700)),
                        border: OutlineInputBorder(),
                        labelText: 'Company/Job',
                        labelStyle: new TextStyle(color: Colors.green.shade700)
                    ),
                    controller: company,
                  )
              ),

              Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade700)),
                        border: OutlineInputBorder(),
                        labelText: 'What were your First Impressions?',
                        labelStyle: new TextStyle(color: Colors.green.shade700)
                    ),
                    controller: impressions,
                  )
              ),

              Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade700)),
                        border: OutlineInputBorder(),
                        labelText: 'What were some Challenges?',
                        labelStyle: new TextStyle(color: Colors.green.shade700)
                    ),
                    controller: challenges,
                  )
              ),

              Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade700)),
                        border: OutlineInputBorder(),
                        labelText: 'What are some Future Suggestions?',
                        labelStyle: new TextStyle(color: Colors.green.shade700)
                    ),
                    controller: suggestions,
                  )
              ),

              Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    "Overall Rating:",
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green.shade700),
                    textScaleFactor: 1.5,
                  )),

              Padding(
                padding:const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: RatingBar(
                  minRating: 0,
                  maxRating: 5,
                  initialRating: widget.entry.quality.toDouble(),
                  allowHalfRating: false,
                  onRatingUpdate: (rate)  {
                    setState(() {
                      rating = rate;
                      check2 = true;
                    });
                  },
                  ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Colors.green.shade700,
                      ),
                      half: Image.asset("star_half.png", color: Colors.green.shade700),
                      empty: Icon(
                        Icons.star,
                        color: Colors.grey,
                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade700
                    ),
                    child: Text('Done'),
                    onPressed: () =>
                        _editJournal(selectedDate, company, rating, impressions, challenges, suggestions)
                ),
              ),
            ],
          )),
    );
  }
}