import 'package:flutter/material.dart';
import 'package:hello3/pages/secound.dart';
import 'package:hello3/pages/third.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Page'),
        ),
        body: Column(
          children: [
            FlatButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SecoundPage();
                  }));
                },
                child: Text(
                  'Goto page 2',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            FlatButton(
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ThirdPage();
                  }));
                },
                child: Text(
                  'Goto page 3',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )),
          ],
        ));
  }
}
