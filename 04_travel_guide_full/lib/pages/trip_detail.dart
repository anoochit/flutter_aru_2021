import 'package:flutter/material.dart';
import 'package:travel_guide_ui/model/trip.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';

class TripDetailPage extends StatefulWidget {
  final Trip trip;
  TripDetailPage({Key key, this.trip}) : super(key: key);

  @override
  _TripDetailPageState createState() => _TripDetailPageState(this.trip);
}

class _TripDetailPageState extends State<TripDetailPage> {
  Trip trip;
  _TripDetailPageState(this.trip);

  Widget tripLocationTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.place),
          Text(trip.city + ', ' + trip.country),
        ],
      ),
    );
  }

  Widget tripTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Text(
        trip.title,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget parseTripBody(String body, List<String> image) {
    List<Widget> listBodyWidget = [];
    var bodyArr = body.split('<<');
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
          child: Image.asset(image[int.parse(tmpImage[0]) - 1]),
        ));
        // log('text  -> ' +
        //     tmpText
        //         .substring((tmpImage[0] + ">>").length, element.length)
        //         .trim());
        listBodyWidget.add(Text(tmpText
            .substring((tmpImage[0] + ">>").length, element.length)
            .trim()));
      } else {
        //log('first text -> ' + element);
        listBodyWidget.add(Text(element));
      }
    });
    return Flex(
      direction: Axis.vertical,
      children: [
        for (int i = 0; i < listBodyWidget.length; i++) listBodyWidget[i]
      ],
    );
  }

  Widget tripBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: parseTripBody(trip.body, trip.image),
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

  tripImageList() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trip.image.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: (index == 0)
                ? EdgeInsets.only(left: 16, right: 4, bottom: 16)
                : EdgeInsets.only(left: 4, right: 4, bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                trip.image[index],
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: SingleChildScrollView(
          child: Container(
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithBackButton(
                  title: 'Trip Details',
                ),
                tripLocationTitle(),
                tripImageList(),
                tripTitle(),
                tripBody(),
                tripSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
