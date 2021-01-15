import 'package:flutter/material.dart';

class CustomAppBarWithBackButton extends StatelessWidget {
  final String title;
  const CustomAppBarWithBackButton({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
