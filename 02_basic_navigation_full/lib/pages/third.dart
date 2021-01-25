import 'package:flutter/material.dart';
import 'package:hello3/pages/first.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Container(
        child: FlatButton(
          onPressed: () {
            // push
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext contaxt) {
                  return FirstPage();
                },
              ),
            );
          },
          child: Text('Goto first page :D'),
        ),
      ),
    );
  }
}
