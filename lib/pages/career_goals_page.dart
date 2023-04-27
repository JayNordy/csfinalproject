import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CareerGoalsPage extends StatefulWidget {
  CareerGoalsPage({Key? key}) : super(key: key);

  @override
  _CareerGoalsPageState createState() => _CareerGoalsPageState();
}

class _CareerGoalsPageState extends State<CareerGoalsPage> {
  List<String> shortTermGoals = [];
  List<String> longTermGoals = [];
  TextEditingController shortTermGoalController = TextEditingController();
  TextEditingController longTermGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    shortTermGoalController.dispose();
    longTermGoalController.dispose();
    super.dispose();
  }

  void addShortTermGoal() {
    setState(() {
      shortTermGoals.add(shortTermGoalController.text);
      shortTermGoalController.clear();
    });
  }

  void addLongTermGoal() {
    setState(() {
      longTermGoals.add(longTermGoalController.text);
      longTermGoalController.clear();
    });
  }

  void checkGoal(int index, bool isShortTermGoal) {
    setState(() {
      if (isShortTermGoal) {
        shortTermGoals[index] = '✅ ' + shortTermGoals[index];
      } else {
        longTermGoals[index] = '✅ ' + longTermGoals[index];
      }
    });
  }

  Widget buildGoalList(List<String> goals, bool isShortTermGoal) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: goals.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(goals[index]),
          trailing: Checkbox(
            value: goals[index].startsWith('✅ '),
            onChanged: (value) => checkGoal(index, isShortTermGoal),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Career Goals"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Short-term goals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: shortTermGoalController,
                decoration: InputDecoration(
                  hintText: 'Add a short-term goal',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addShortTermGoal,
                  ),
                ),
              ),
              SizedBox(height: 16),
              buildGoalList(shortTermGoals, true),
              SizedBox(height: 32),
              Text(
                'Long-term goals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: longTermGoalController,
                decoration: InputDecoration(
                  hintText: 'Add a long-term goal',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addLongTermGoal,
                  ),
                ),
              ),
              SizedBox(height: 16),
              buildGoalList(longTermGoals, false),
            ],
          ),
        ),
      ),
    );
  }
}