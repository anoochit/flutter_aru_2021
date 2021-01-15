import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        left: 16,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            'Explore Cities',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          CircleAvatar(
            radius: 21,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
