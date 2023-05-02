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

class _CareerGoalsPageState extends State<CareerGoalsPage> with TickerProviderStateMixin {
  TextEditingController shortTermGoalController = TextEditingController();
  TextEditingController longTermGoalController = TextEditingController();
  int completedGoalsCount = 0;

  @override
  void initState() {
    super.initState();
  }

  void editGoal(int index, bool isShortTermGoal, String updatedGoal) {
    setState(() {
      if (isShortTermGoal) {
        widget.shortTermGoals[index] = updatedGoal;
      } else {
        widget.longTermGoals[index] = updatedGoal;
      }
    });
  }

  Future<void> showEditGoalDialog(int index, bool isShortTermGoal) async {
    TextEditingController editGoalController = TextEditingController(
      text: isShortTermGoal
          ? widget.shortTermGoals[index]
          : widget.longTermGoals[index],
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Goal'),
          content: TextField(
            controller: editGoalController,
            decoration: InputDecoration(
              hintText: 'Update the goal',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                editGoal(
                  index,
                  isShortTermGoal,
                  editGoalController.text.trim(),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




  @override
  void dispose() {
    shortTermGoalController.dispose();
    longTermGoalController.dispose();
    super.dispose();
  }

  void addShortTermGoal() {
    String goal = shortTermGoalController.text.trim();
    if (goal.isNotEmpty) {
      setState(() {
        widget.shortTermGoals.add(goal);
        shortTermGoalController.clear();
      });
    }
  }

  void addLongTermGoal() {
    String goal = longTermGoalController.text.trim();
    if (goal.isNotEmpty) {
      setState(() {
        widget.longTermGoals.add(goal);
        longTermGoalController.clear();
      });
    }
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
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: isChecked ? 0.5 : 1.0,
      child: Card(
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
                activeColor: Theme.of(context).primaryColor,
                value: isChecked,
                onChanged: (value) => toggleCheckGoal(index, isShortTermGoal),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => showEditGoalDialog(index, isShortTermGoal),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteGoal(index, isShortTermGoal),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget slideFadeTransition(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.3),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  Widget scaleTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  Widget buildGoalList(List<String> goals, bool isShortTermGoal) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: goals.length,
      itemBuilder: (BuildContext context, int index) {
        Animation<double> animation = CurvedAnimation(
          parent: Tween<double>(begin: 0.0, end: 1.0).animate(
            AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 400),
            )..forward(),
          ),
          curve: Interval(0.1 * index, 1.0, curve: Curves.easeInOut),
        );
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return slideFadeTransition(child!, animation);
          },
          child: buildGoalCard(goals[index], index, isShortTermGoal),
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
              Container(
                height: 200,
                child: SingleChildScrollView(
                  child: buildGoalList(widget.shortTermGoals, true),
                ),
              ),
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
              Container(
                height: 200,
                child: SingleChildScrollView(
                  child: buildGoalList(widget.longTermGoals, false),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    int totalGoals = widget.shortTermGoals.length + widget.longTermGoals.length;
                    int completedGoals = widget.shortTermGoals.where((goal) => goal.startsWith('[x] ')).length +
                        widget.longTermGoals.where((goal) => goal.startsWith('[x] ')).length;
                    double completionPercentage = completedGoals / totalGoals;
                    if (completionPercentage >= 1.0) {
                      completedGoalsCount++;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Congratulations!'),
                            content: Text('You have completed your career goals for now.\n\n'
                                'You have completed your goals ${completedGoalsCount} times.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {
                        widget.shortTermGoals.clear();
                        widget.longTermGoals.clear();
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Incomplete goals'),
                            content: Text('You still have incomplete goals. Complete all of your goals before marking them as completed.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Complete your career goals'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
