import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/pages/profile.dart';
import 'package:travel_guide_ui/pages/signin.dart';
import 'package:travel_guide_ui/services/googlesignin.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        left: 16,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            'Explore Cities',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            child: CircleAvatar(
              radius: 21,
              backgroundColor: Colors.grey,
              // if user already sign-in show user image
              child: (currentUser == null)
                  ? Icon(
                      Icons.person,
                      color: Colors.black,
                    )
                  : Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child:
                            CachedNetworkImage(imageUrl: currentUser.photoUrl),
                      ),
                    ),
            ),
            onTap: () {
              // Let's check user id
              if (currentUser != null) {
                // if not null goto profile page
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext contex) {
                  return ProfilePage();
                }));
              } else {
                // if null goto sign-in page
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext contex) {
                  return SignInPage();
                }));
              }
            },
          ),
        ],
      ),
    );
  }
}
