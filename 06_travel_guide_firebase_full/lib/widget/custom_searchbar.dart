import 'package:flutter/material.dart';
import 'package:travel_guide_ui/pages/search.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
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
                onFieldSubmitted: (keyword) => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return SearchPage(keyword: keyword);
                })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
