import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, bottom: 28.0),
      child: Container(
        height: 43,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  fillColor: Colors.grey,
                  hintText: 'Search',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
