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

  void toggleCheckGoal(int index, bool isShortTermGoal) {
    setState(() {
      if (isShortTermGoal) {
        if (shortTermGoals[index].startsWith('✅ ')) {
          shortTermGoals[index] = shortTermGoals[index].substring(2);
        } else {
          shortTermGoals[index] = '✅ ' + shortTermGoals[index];
        }
      } else {
        if (longTermGoals[index].startsWith('✅ ')) {
          longTermGoals[index] = longTermGoals[index].substring(2);
        } else {
          longTermGoals[index] = '✅ ' + longTermGoals[index];
        }
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
            onChanged: (value) => toggleCheckGoal(index, isShortTermGoal),
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Short-term goals',
                style: Theme.of(context).textTheme.headline6,
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
                style: Theme.of(context).textTheme.headline6,
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
