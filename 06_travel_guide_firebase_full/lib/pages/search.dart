import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Widget searchItem(BuildContext context, int index, List<String> data) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('trips').doc(data[index]).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
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
                      future: FirebaseFirestore.instance.collection('cities').doc(doc['city']).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                        // child: Image.network(
                        //   doc['image'][0],
                        //   fit: BoxFit.cover,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: doc['image'][0],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 16.0,
                        bottom: 16.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['name'],
                              style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            FutureBuilder(
                              future: FirebaseFirestore.instance.collection('cities').doc(doc['city']).get(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data['name'] + ', ' + snapshot.data['country']}',
                                    style: TextStyle(color: Colors.white, fontSize: 12.0),
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return TripDetailPage(trip: doc);
              }));
            },
          );
        }
        return Container();
      },
    );
  }

  Widget searchList(String keyword) {
    return Expanded(
      child: FutureBuilder(
        future: searchTrip(keyword),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return searchItem(context, index, snapshot.data);
              },
            );
          }
          return Container();
        },
      ),
    );
    // return ListView.builder(
    //   itemCount: listPlace.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return searchItem(context, index, listPlace);
    //   },
    // );
  }

  Widget searchTitle(int total) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
      child: Text(
        'Result ${total.toString()} trips found',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<List<String>> searchTrip(String keyword) async {
    List<String> docId = [];
    var value = await FirebaseFirestore.instance.collection('trips').get();
    value.docs.forEach((element) {
      var title = element['name'].toString().toLowerCase();
      var body = element['body'].toString().toLowerCase();
      if (body.contains(keyword)) docId.add(element.id);
      if (title.contains(keyword)) docId.add(element.id);
    });
    return docId;
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
            searchList(this.keyword),
          ],
        ),
      ),
    );
  }
}
