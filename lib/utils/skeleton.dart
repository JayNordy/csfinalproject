/*

Add to main within the page's button
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PageName(database: database)));
  },
]


File Skeleton [
    import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';

    class PageName extends StatefulWidget {

      PageName({Key? key}) : super (key: key);

      @override
      _PageNameState createState() => _PageNameState();
    }

    class _PageNameState extends State<PageName>  {
      @override
      void initState() {
        super.initState();
      }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
            centerTitle: true,
            backgroundColor: Colors.green.shade700,
          ),
          backgroundColor: Colors.white,
          body: Center(
              child: Column(
                children: <Widget>[
                  //Insert the build within here
                ],
              )
          ),
        );
      }
    }
]
 */