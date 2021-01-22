import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:travel_guide_ui/pages/home.dart';
import 'package:travel_guide_ui/services/googlesignin.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  saveUser(UserCredential userCredential) {
    // save new user to firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        log('Already has user in firestore collection');
      } else {
        log('No user data in firestore collection');
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'name': userCredential.user.displayName,
          'image': userCredential.user.photoURL
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 42),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWithBackButton(
                title: 'Sing in',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Please sign-in with your google account.'),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SignInButton(Buttons.Google, onPressed: () {
                  handleSignIn().then((userCredential) {
                    // save user to firebase database
                    saveUser(userCredential);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomePage();
                    }));
                  });
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
