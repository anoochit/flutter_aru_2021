import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:travel_guide_ui/pages/error.dart';
import 'package:travel_guide_ui/pages/home.dart';
import 'package:travel_guide_ui/pages/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Firebase initialized
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // not show debug banner
      title: 'Travel Guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // transparent status bar
          systemNavigationBarColor: Colors.black, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: FutureBuilder(
            future: _initialization,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return ErrorPage();
              }
              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return HomePage();
              }
              // Waiting for firebase initialized show loading page
              return LoadingPage();
            }),
      ),
    );
  }
}
