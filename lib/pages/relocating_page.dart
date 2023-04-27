import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/database.dart';

class RelocatingPage extends StatefulWidget {
  RelocatingPage({Key? key, required this.data}) : super(key: key);
  JobData data;

  @override
  _RelocatingState createState() => _RelocatingState();
}

class _RelocatingState extends State<RelocatingPage> {
  @override
  void initState() {
    super.initState();
  }

  int startLoc = 1856;
  int endLoc = 1856;
  double rent = 0;
  double own = 0;
  double living = 0;
  String startLocLabel = "Select Current City";
  String endLocLabel = "Select Future City";
  NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");
  Color rentColor = Colors.green.shade700;
  Color ownColor = Colors.green.shade700;
  Color livingColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    locationGetter() {
      List<Widget> content = [];
      for (int i = 0; i < widget.data.database.length; ++i) {
        content.add(Text(widget.data.getData(index: i)[0].city.toString()));
      }
      return content;
    }

    rentEstimator() {
      if (endLoc == 1856) {
        return "--.--";
      } else {
        rent = widget.data.getData(index: endLoc)[0].rentAvg;
        return currencyFormat.format(rent).toString();
      }
    }

    ownEstimator() {
      if (endLoc == 1856) {
        return "--.--";
      } else {
        own = widget.data.getData(index: endLoc)[0].medianHome.toDouble();
        return currencyFormat.format(own).toString();
      }
    }

    livingEstimator() {
      if (endLoc == 1856) {
        return "--.--";
      } else {
        living = widget.data.getData(index: endLoc)[0].livingCost;
        return currencyFormat.format(living).toString();
      }
    }

    rentDifferenceEstimator() {
      if (endLoc == 1856 || startLoc == 1856) {
        return "--.--";
      } else {
        double tempDiff = 0;
        tempDiff = widget.data.getData(index: endLoc)[0].rentAvg -
            widget.data.getData(index: startLoc)[0].rentAvg;
        if (tempDiff > 0) {
          setState(() {
            rentColor = Colors.redAccent;
          });
        } else if (tempDiff <= 0) {
          setState(() {
            rentColor = Colors.green.shade700;
          });
        }
        return currencyFormat.format(tempDiff).toString();
      }
    }

    ownDifferenceEstimator() {
      if (endLoc == 1856 || startLoc == 1856) {
        return "--.--";
      } else {
        double tempDiff = 0;
        tempDiff = widget.data.getData(index: endLoc)[0].medianHome.toDouble() -
            widget.data.getData(index: startLoc)[0].medianHome;
        if (tempDiff > 0) {
          setState(() {
            ownColor = Colors.redAccent;
          });
        } else if (tempDiff <= 0) {
          setState(() {
            ownColor = Colors.green.shade700;
          });
        }
        return currencyFormat.format(tempDiff).toString();
      }
    }

    livingDifferenceEstimator() {
      if (endLoc == 1856 || startLoc == 1856) {
        return "--.--";
      } else {
        double tempDiff = 0;
        tempDiff = widget.data.getData(index: endLoc)[0].livingCost -
            widget.data.getData(index: startLoc)[0].livingCost;
        if (tempDiff > 0) {
          setState(() {
            livingColor = Colors.redAccent;
          });
        } else if (tempDiff <= 0) {
          setState(() {
            livingColor = Colors.green.shade700;
          });
        }
        return currencyFormat.format(tempDiff).toString();
      }
    }

    buildPicker1() {
      return SizedBox(
          height: 250,
          child: CupertinoPicker(
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: Colors.green.shade700.withOpacity(0.2),
            ),
            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              setState(() {
                startLoc = value;
                startLocLabel =
                    widget.data.getData(index: value)[0].city.toString();
              });
            },
            itemExtent: 32.0,
            children: locationGetter(),
          ));
    }

    showPicker1() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
                actions: [buildPicker1()],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('Cancel',
                      style: TextStyle(color: Colors.green.shade700)),
                  onPressed: () => Navigator.pop(context),
                ),
              ));
    }

    buildPicker2() {
      return SizedBox(
          height: 250,
          child: CupertinoPicker(
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: Colors.green.shade700.withOpacity(0.2),
            ),
            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              setState(() {
                endLoc = value;
                endLocLabel =
                    widget.data.getData(index: value)[0].city.toString();
              });
            },
            itemExtent: 32.0,
            children: locationGetter(),
          ));
    }

    showPicker2() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
                actions: [buildPicker2()],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('Cancel',
                      style: TextStyle(color: Colors.green.shade700)),
                  onPressed: () => Navigator.pop(context),
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Relocating Estimator"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Text(
                "Relocating Estimator",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green.shade700),
                textScaleFactor: 3,
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
              onPressed: showPicker1,
              child: Text(startLocLabel),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green.shade700),
                  onPressed: showPicker2,
                  child: Text(endLocLabel),
                )),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Cost to Rent per Month: \$",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.5,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  rentEstimator(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.5,
                )),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  "Difference in Rent: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.2,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  rentDifferenceEstimator(),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: rentColor),
                  textScaleFactor: 1.2,
                )),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Cost to Buy a House: \$",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.5,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  ownEstimator(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.5,
                )),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  "Difference in Mortgage: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.2,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  ownDifferenceEstimator(),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: ownColor),
                  textScaleFactor: 1.2,
                )),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Cost of Living per Year: \$",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.5,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  livingEstimator(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.5,
                )),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  "Difference in Living: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700),
                  textScaleFactor: 1.2,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  livingDifferenceEstimator(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: livingColor),
                  textScaleFactor: 1.2,
                )),
          ]),
        ],
      )),
    );
  }
}
