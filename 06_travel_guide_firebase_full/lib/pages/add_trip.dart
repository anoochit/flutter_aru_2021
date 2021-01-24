import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_ui/widget/custom_appbar_backbutton.dart';

class AddTripPage extends StatefulWidget {
  AddTripPage({Key key}) : super(key: key);

  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  var formKey = new GlobalKey<FormState>();

  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();

  Widget addTripForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('cities').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var doc = snapshot.data.docs;
                  return DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select City",
                    ),
                    items: doc.map((city) {
                      return DropdownMenuItem<String>(
                        value: city.id.toString(),
                        child: Text(
                          city['name'] + ', ' + city['country'],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      log(value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select city';
                      }
                      return null;
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //labelText: "Text",
                hintText: "Your trip title",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter trip title';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: TextFormField(
              controller: bodyController,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //labelText: "Text",
                hintText: "Your trip detail",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter trip detail';
                }
                return null;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: FlatButton(
              color: Colors.black,
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  log("ok your text is not empty");
                  // save and pop
                  Navigator.pop(context, true);
                }
              },
            ),
          ),
        ],
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
          child: Column(
            children: [
              CustomAppBarWithBackButton(title: 'Write your trip'),
              Expanded(
                child: SingleChildScrollView(
                  child: addTripForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
