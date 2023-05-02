
import 'package:flutter/material.dart';
import 'pages/job_search_page.dart';
import 'pages/relocating_page.dart';
import 'pages/journal_page.dart';
import 'pages/comparing_page.dart';
import 'pages/video_page.dart';
import 'pages/sound_page.dart';
import 'pages/career_goals_page.dart';
import 'package:finalproject/utils/journal.dart';
import 'utils/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String journalFile = "journalData.🂿sv";
  Journal journal = Journal();
  JobData data = JobData();
  List<String> shortTermGoals = [];
  List<String> longTermGoals = [];


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text("Job Market"),
                    backgroundColor: Colors.green.shade700,
                    centerTitle: true,
                  ),
                  body: Center(
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Job Market",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700),
                            textScaleFactor: 3,
                          ),
                        ),
                        Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 20, top: 20),
                            child: SizedBox(
                              width: 150, // <-- match_parent
                              height: 150, // <-- match-parent
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade700),
                                child: const Text('Job Search'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JobSearchPage(data: data)));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade700),
                                child: const Text('Relocating Estimator'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RelocatingPage(data: data)));
                                },
                              ),
                            ),
                          )
                        ]),
                        Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 20, top: 20),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade700),
                                child: const Text('Salary Comparison'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ComparingPage(jobData: data)));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade700),
                                child: const Text('Job Journal'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JournalPage(journal: journal)));
                                },
                              ),
                            ),
                          )
                        ]),
                        Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 20, top: 20),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade700),
                                child: const Text('Helpful Videos'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoPage()));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade700),
                                child: const Text('Music & Motivational Speeches'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SoundsPage()));
                                },
                              ),
                            ),
                          )
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
                              child: const Text('Career Goals'),
                              onPressed: () async {
                                //wait for page to exit before setting "soundsLoaded" to true
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CareerGoalsPage(
                                      shortTermGoals: shortTermGoals,
                                      longTermGoals: longTermGoals,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
