import 'package:flutter/material.dart';
import 'package:travel_guide_ui/model/place.dart';
import 'package:travel_guide_ui/model/trip.dart';
import 'package:travel_guide_ui/pages/trip_detail.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';
import 'package:travel_guide_ui/widget/custom_searchbar.dart';

class SearchPage extends StatefulWidget {
  final String keyword;
  SearchPage({Key key, this.keyword}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(this.keyword);
}

class _SearchPageState extends State<SearchPage> {
  String keyword;
  _SearchPageState(this.keyword);

  Widget searchItem(BuildContext context, int index, List<Place> listPlace) {
    return InkWell(
      child: Container(
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
                    listPlace[index].city + ', ' + listPlace[index].country,
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
                    listPlace[index].image,
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
                        listPlace[index].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        listPlace[index].city + ', ' + listPlace[index].country,
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return TripDetailPage(trip: listTrip[index]);
        }));
      },
    );
  }

  Widget searchList(List<Place> listPlace) {
    return ListView.builder(
      itemCount: listPlace.length,
      itemBuilder: (BuildContext context, int index) {
        return searchItem(context, index, listPlace);
      },
    );
  }

  Widget searchTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
      child: Text(
        'Result ${listPlace.length} cities found',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            CustomAppBarWithBackButton(title: 'Search'),
            CustomSearchBar(),
            searchTitle(),
            Expanded(
              child: searchList(listPlace),
            ),
          ],
        ),
      ),
    );
  }
}
