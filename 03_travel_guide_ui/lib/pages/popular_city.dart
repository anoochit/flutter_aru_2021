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
  Widget popularCityItem(BuildContext context, List<City> item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 245,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              item[index].image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          item[index].name,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
          item[index].country,
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }

  Widget popularCityGridView(List<City> listCity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width / 2) /
              ((MediaQuery.of(context).size.height - 24 - (110)) / 2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return popularCityItem(context, listCity, index);
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
