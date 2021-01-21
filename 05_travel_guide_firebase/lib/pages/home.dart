import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/pages/popular_city.dart';
import 'package:travel_guide_ui/pages/trending_place.dart';
import 'package:travel_guide_ui/widget/custom_appbar.dart';
import 'package:travel_guide_ui/widget/custom_searchbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget popularCityItem(
      BuildContext context, List<QueryDocumentSnapshot> item, int index) {
    return Padding(
      padding: EdgeInsets.only(
        left: (index == 0) ? 16 : 0,
        right: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 245,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              // child: Image.asset(
              //   item[index].image,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: item[index]['image'],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            item[index]['name'],
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item[index]['country'],
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget popularCityTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            'Popular Cities',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            child: Text(
              'View All',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return PopularCityPage();
            })),
          ),
        ],
      ),
    );
  }

  Widget popularCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        popularCityTitle(),
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: 293,
          // child: ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: 4,
          //   itemBuilder: (BuildContext context, int index) {
          //     return popularCityItem(context, listCity, index);
          //   },
          // ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('cities').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return popularCityItem(context, doc, index);
                  },
                );
              }
              return Center(child: Text('Loading...'));
            },
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
      ],
    );
  }

  Widget trendingPlaceTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            'Trending Places',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            child: Text(
              'View All',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrendingPlacePage(),
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget trendingPlaceItem(
      BuildContext context, List<QueryDocumentSnapshot> listPlace, int index) {
    return Container(
      width: 160,
      height: 77,
      padding: EdgeInsets.only(
        left: (index == 0) ? 16 : 0,
        right: 8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        // child: Image.network(
        //   listPlace[index]['image'][0],
        //   fit: BoxFit.cover,
        // ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: listPlace[index]['image'][0],
          placeholder: (context, url) => Container(color: Colors.grey),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget trendingPlace() {
    return Container(
      child: Column(
        children: [
          trendingPlaceTitle(),
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 77,
            // child: ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 4,
            //   itemBuilder: (BuildContext context, int index) {
            //     return trendingPlaceItem(context, listPlace, index);
            //   },
            // ),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('trips').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var doc = snapshot.data.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return trendingPlaceItem(context, doc, index);
                    },
                  );
                }
                return Center(child: Text('Loading...'));
              },
            ),
          ),
          SizedBox(
            height: 32.0,
          ),
        ],
      ),
    );
  }

  Widget travelWithFriendTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            'Travel with Friends',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            'View All',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget travelWithFriend() {
    return Container(
      child: Column(
        children: [
          travelWithFriendTitle(),
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 60,
            // child: ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 6,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding:
            //           EdgeInsets.only(left: (index == 0) ? 16 : 0, right: 8.0),
            //       child: CircleAvatar(
            //         radius: 30,
            //         child: Image.asset(listPeople[index].image),
            //       ),
            //     );
            //   },
            // ),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var doc = snapshot.data.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: (index == 0) ? 16 : 0,
                          right: 8.0,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          //child: Image.network(doc[index]['image']),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: doc[index]['image'],
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Text('Loading...');
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO 01 : create project in your firebase account
    // see this link - https://firebase.flutter.dev/docs/installation/android
    // and this link - https://firebase.flutter.dev/docs/overview

    // TODO 02 : add mockup data
    // addMockupData();

    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: Flex(
          direction: Axis.vertical,
          children: [
            CustomAppBar(),
            CustomSearchBar(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  popularCity(),
                  trendingPlace(),
                  travelWithFriend(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
