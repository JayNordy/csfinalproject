import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:finalproject/utils/journal.dart';

class CreateJournalPage extends StatefulWidget {
  CreateJournalPage({Key? key, required this.journal}) : super(key: key);
  Journal journal;

  @override
  _CreateJournalPageState createState() => _CreateJournalPageState();
}

class _CreateJournalPageState extends State<CreateJournalPage> {
  @override
  void initState() {
    super.initState();
  }

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;

  var company = TextEditingController();
  var impressions = TextEditingController();
  var challenges = TextEditingController();
  var suggestions = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double rating = 0;

  String labelSelectDate = "Select a Date";
  String labelError = "";

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

    _createJournal(DateTime selectedDate, var company, double rating, var impressions, var challenges, var suggestions) async {
      if ((check1 != false) && (check2 != false) && (check3 != false) && (check4 != false)) {
        widget.journal.addEvent(selectedDate, Company: company.text, Quality: rating.toInt(),
            Impressions: impressions.text, Challenges: challenges.text, Suggestions: suggestions.text);
        Navigator.pop(context);
      }

      else  {
        setState(() {
          labelError = "Error: Not all Entries are Filled";
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create Journal"),
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
                "New Job Journal",
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
                    //counterStyle: new TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade700)),
                    border: OutlineInputBorder(),
                    labelText: 'Company/Job',
                    labelStyle: new TextStyle(color: Colors.green.shade700)
                ),
                //style: TextStyle(color: Colors.white),
                //cursorColor: Colors.white,
                controller: company,
                onTap: () {
                  check2 = true;
                },
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
                //style: TextStyle(color: Colors.white),
                //cursorColor: Colors.white,
                controller: impressions,
                onTap: () {
                  check3 = true;
                },
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
                //style: TextStyle(color: Colors.white),
                //cursorColor: Colors.white,
                controller: challenges,
                onTap: () {
                  check4 = true;
                },
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
                //style: TextStyle(color: Colors.white),
                //cursorColor: Colors.white,
                controller: suggestions,
                onTap: () {
                  check5 = true;
                },
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
              initialRating: 3,
              allowHalfRating: false,
              onRatingUpdate: (rate)  {
                setState(() {
                  rating = rate;
                  check3 = true;
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
                    _createJournal(selectedDate, company, rating, impressions, challenges, suggestions)
            ),
          ),

          Padding(
              padding: EdgeInsets.only(top: 20.0,),
              child: Text(labelError, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
                textScaleFactor: 2,
                textAlign: TextAlign.center,)
          ),
        ],
      )),
    );
  }
}
