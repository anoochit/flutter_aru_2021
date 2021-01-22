import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/model/citiy.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';
import 'package:travel_guide_ui/widget/custom_searchbar.dart';

class PopularCityPage extends StatefulWidget {
  PopularCityPage({Key key}) : super(key: key);

  @override
  _PopularCityPageState createState() => _PopularCityPageState();
}

class _PopularCityPageState extends State<PopularCityPage> {
  Widget popularCityItem(
      BuildContext context, List<QueryDocumentSnapshot> item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 245,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            // child: Image.asset(
            //   item[index]['image'],
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
    );
  }

  Widget popularCityGridView(List<City> listCity) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = 24.0;
    double actionItemHeight = 110.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // child: GridView.builder(
      //   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio: (screenWidth / 2) /
      //         ((screenHeight - statusBarHeight - (actionItemHeight)) / 2),
      //     mainAxisSpacing: 8.0,
      //     crossAxisSpacing: 8.0,
      //   ),
      //   itemCount: 4,
      //   itemBuilder: (BuildContext context, int index) {
      //     return popularCityItem(context, listCity, index);
      //   },
      // ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cities').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data.docs;
            return GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (screenWidth / 2) /
                    ((screenHeight - statusBarHeight - (actionItemHeight)) / 2),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: doc.length,
              itemBuilder: (BuildContext context, int index) {
                return popularCityItem(context, doc, index);
              },
            );
          }

          return Text('Loading...');
        },
      ),
    );
  }

  Widget popularCityTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
      child: Text(
        'Result ${listCity.length} cities found',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42.0),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarWithBackButton(title: 'Popular Cities'),
            CustomSearchBar(),
            popularCityTitle(),
            Expanded(
              child: popularCityGridView(listCity),
            ),
          ],
        ),
      ),
    );
  }
}
