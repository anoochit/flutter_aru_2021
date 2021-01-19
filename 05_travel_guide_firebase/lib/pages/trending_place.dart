import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/model/place.dart';
import 'package:travel_guide_ui/model/trip.dart';
import 'package:travel_guide_ui/pages/trip_detail.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';
import 'package:travel_guide_ui/widget/custom_searchbar.dart';

class TrendingPlacePage extends StatefulWidget {
  TrendingPlacePage({Key key}) : super(key: key);

  @override
  _TrendingPlacePageState createState() => _TrendingPlacePageState();
}

class _TrendingPlacePageState extends State<TrendingPlacePage> {
  Widget trendingPlaceItem(
      BuildContext context, int index, List<QueryDocumentSnapshot> listPlace) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('cities')
                    .doc(listPlace[index]['city'])
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Icon(Icons.place),
                        Text(
                          '${snapshot.data['name'] + ', ' + snapshot.data['country']}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }

                  return Container();
                },
              ),
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    imageUrl: listPlace[index]['image'][0],
                    placeholder: (context, url) => Container(
                      color: Colors.grey,
                    ),
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
                        listPlace[index]['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('cities')
                            .doc(listPlace[index]['city'])
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data['name'] + ', ' + snapshot.data['country']}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            );
                          }

                          return Container();
                        },
                      ),
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

  Widget trendingPlaceList(List<Place> listPlace) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('trips').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data.docs;
          return ListView.builder(
            itemCount: listPlace.length,
            itemBuilder: (BuildContext context, int index) {
              return trendingPlaceItem(context, index, doc);
            },
          );
        }

        return Container();
      },
    );
  }

  Widget trendingPlaceTitle() {
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
            CustomAppBarWithBackButton(title: 'Trending Places'),
            CustomSearchBar(),
            trendingPlaceTitle(),
            Expanded(
              child: trendingPlaceList(listPlace),
            ),
          ],
        ),
      ),
    );
  }
}
