import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';

class TripDetailPage extends StatefulWidget {
  final DocumentSnapshot trip;
  TripDetailPage({Key key, this.trip}) : super(key: key);

  @override
  _TripDetailPageState createState() => _TripDetailPageState(this.trip);
}

class _TripDetailPageState extends State<TripDetailPage> {
  DocumentSnapshot trip;
  _TripDetailPageState(this.trip);

  Widget tripLocationTitle(DocumentSnapshot trip) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('cities').doc(trip['city']).get(),
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
    );
  }

  Widget tripTitle(DocumentSnapshot trip) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Text(
        trip['name'],
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget parseTripBody(trip) {
    List<Widget> listBodyWidget = [];

    var bodyArr = trip['body'].split('<<');
    //log('body -> ' + body);
    //log('body split total -> ${bodyArr.length}');
    bodyArr.forEach((element) {
      //log(element);
      if (element.contains('>>')) {
        var tmpImage = element;
        var tmpText = element;
        tmpImage.split(new RegExp("^[0-9]"));
        //log('image  -> ' + tmpImage[0]);
        listBodyWidget.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          //child: Image.network(trip['image'][int.parse(tmpImage[0]) - 1]),
          child: CachedNetworkImage(
            imageUrl: trip['image'][int.parse(tmpImage[0]) - 1],
          ),
        ));
        // log('text  -> ' + tmpText.substring((tmpImage[0] + ">>").length, element.length).trim());
        listBodyWidget.add(Text(tmpText.substring((tmpImage[0] + ">>").length, element.length).trim()));
      } else {
        //log('first text -> ' + element);
        listBodyWidget.add(Text(element));
      }
    });
    return Flex(
      direction: Axis.vertical,
      children: [for (int i = 0; i < listBodyWidget.length; i++) listBodyWidget[i]],
    );
  }

  Widget tripBody(DocumentSnapshot trip) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: parseTripBody(trip),
    );
  }

  Widget tripSaveButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: SizedBox(
        width: double.infinity, // match_parent
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // background
            onPrimary: Colors.white, // foreground
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Save Trip',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          onPressed: () {
            // do somthings
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWithBackButton(
                title: 'Trip Details',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tripLocationTitle(this.trip),
                      tripTitle(this.trip),
                      tripBody(this.trip),
                      tripSaveButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
