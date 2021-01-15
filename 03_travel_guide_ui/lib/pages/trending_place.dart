import 'package:flutter/material.dart';
import 'package:travel_guide_ui/model/place.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';
import 'package:travel_guide_ui/widget/custom_searchbar.dart';

class TrendingPlacePage extends StatefulWidget {
  TrendingPlacePage({Key key}) : super(key: key);

  @override
  _TrendingPlacePageState createState() => _TrendingPlacePageState();
}

class _TrendingPlacePageState extends State<TrendingPlacePage> {
  Widget trendingPlaceItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Icon(Icons.place),
                Text(
                  listPlace[0].city + ', ' + listPlace[0].country,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  listPlace[0].image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 16.0,
                bottom: 16.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listPlace[0].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      listPlace[0].city + ', ' + listPlace[0].country,
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: Flex(
          direction: Axis.vertical,
          children: [
            CustomAppBarWithBackButton(title: 'Trending Places'),
            CustomSearchBar(),
            trendingPlaceItem()
          ],
        ),
      ),
    );
  }
}
