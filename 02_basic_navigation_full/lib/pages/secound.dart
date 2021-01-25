import 'package:flutter/material.dart';

class SecoundPage extends StatefulWidget {
  SecoundPage({Key key}) : super(key: key);

  @override
  _SecoundPageState createState() => _SecoundPageState();
}

class _SecoundPageState extends State<SecoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secound Page'),
      ),
      body: Container(
        child: FlatButton(
          onPressed: () {
            // pop
            Navigator.pop(context);
          },
          child: Text('Goto first page :D'),
        ),
      ),
    );
  }
}
