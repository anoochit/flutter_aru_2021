import 'package:basic_navigation/pages/secound.dart';
import 'package:basic_navigation/pages/third.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            FlatButton(
              color: Colors.amber,
              child: Text('Goto secound page'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SecoundPage();
                }));
              },
            ),
            FlatButton(
              color: Colors.red,
              child: Text('Goto thirds page'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ThirdPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
