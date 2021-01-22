import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/services/googlesignin.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 42,
                        child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl: currentUser.photoUrl))),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      currentUser.displayName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.red,
                child: Text('Sign Out'),
                onPressed: () => handleSignOut(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
