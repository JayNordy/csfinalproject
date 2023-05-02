import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CareerGoalsPage extends StatefulWidget {
  final List<String> shortTermGoals;
  final List<String> longTermGoals;

  CareerGoalsPage({
    Key? key,
    required this.shortTermGoals,
    required this.longTermGoals,
  }) : super(key: key);

  @override
  _CareerGoalsPageState createState() => _CareerGoalsPageState();
}

class _CareerGoalsPageState extends State<CareerGoalsPage> {
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
      widget.shortTermGoals.add(shortTermGoalController.text); // Update this line
      shortTermGoalController.clear();
    });
  }

  void addLongTermGoal() {
    setState(() {
      widget.longTermGoals.add(longTermGoalController.text); // Update this line
      longTermGoalController.clear();
    });
  }


  void toggleCheckGoal(int index, bool isShortTermGoal) {
    setState(() {
      if (isShortTermGoal) {
        if (widget.shortTermGoals[index].startsWith('[x] ')) { // Change here
          widget.shortTermGoals[index] = widget.shortTermGoals[index].substring(4); // Change here
        } else {
          widget.shortTermGoals[index] = '[x] ' + widget.shortTermGoals[index]; // Change here
        }
      } else {
        if (widget.longTermGoals[index].startsWith('[x] ')) { // Change here
          widget.longTermGoals[index] = widget.longTermGoals[index].substring(4); // Change here
        } else {
          widget.longTermGoals[index] = '[x] ' + widget.longTermGoals[index]; // Change here
        }
      }
    });
  }


  void deleteGoal(int index, bool isShortTermGoal) {
    setState(() {
      if (isShortTermGoal) {
        widget.shortTermGoals.removeAt(index); // Change here
      } else {
        widget.longTermGoals.removeAt(index); // Change here
      }
    });
  }

  Widget buildGoalCard(String goal, int index, bool isShortTermGoal) {
    bool isChecked = goal.startsWith('[x] ');
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          isChecked ? goal.substring(4) : goal,
          style: TextStyle(
            color: isChecked ? Colors.green : null,
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              checkColor: Colors.white,
              activeColor: Theme
                  .of(context)
                  .primaryColor,
              value: isChecked,
              onChanged: (value) => toggleCheckGoal(index, isShortTermGoal),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteGoal(index, isShortTermGoal),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGoalList(List<String> goals, bool isShortTermGoal) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: goals.length,
      itemBuilder: (BuildContext context, int index) {
        return buildGoalCard(goals[index], index, isShortTermGoal);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Career Goals"),
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Short-term goals',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
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
              Container(
                height: 200,
                child: SingleChildScrollView(
                  child: buildGoalList(widget.shortTermGoals, true), // Change here
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Long-term goals',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
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
              Container(
                height: 200,
                child: SingleChildScrollView(
                  child: buildGoalList(widget.longTermGoals, false), // Change here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
