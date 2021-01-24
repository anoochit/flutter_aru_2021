import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/pages/add_trip.dart';
import 'package:travel_guide_ui/pages/trip_detail.dart';
import 'package:travel_guide_ui/services/googlesignin.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  actionBarProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 42, child: ClipOval(child: CachedNetworkImage(imageUrl: currentUser.photoUrl))),
          SizedBox(
            width: 8.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width - (32 + 42 + 42 + 14),
            child: Text(
              currentUser.displayName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  signOutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FlatButton(
          color: Colors.black,
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () => handleSignOut(context),
        ),
      ),
    );
  }

  yourTripTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Row(
        children: [
          Text(
            'Your trip',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              var result = Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return AddTripPage();
              }));
              result.then((value) {
                log(value.toString());
              });
            },
          ),
        ],
      ),
    );
  }

  yourTripListItem(BuildContext context, int index, List<QueryDocumentSnapshot> listPlace) {
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
                future: FirebaseFirestore.instance.collection('cities').doc(listPlace[index]['city']).get(),
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
                        style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection('cities').doc(listPlace[index]['city']).get(),
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
          return TripDetailPage(trip: listPlace[index]);
        }));
      },
    );
  }

  yourTripList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('trips').where('user', isEqualTo: firebaseUser.user.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data.docs;
          if (snapshot.data.docs.length > 0) {
            return ListView.builder(
              itemCount: doc.length,
              itemBuilder: (context, index) {
                return yourTripListItem(context, index, doc);
              },
            );
          } else {
            return Center(
              child: Text('no trip data!!'),
            );
          }
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: Container(
          child: Column(
            children: [
              actionBarProfile(context),
              yourTripTitle(),
              Expanded(
                child: yourTripList(),
              ),

              // signn out button
              signOutButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
