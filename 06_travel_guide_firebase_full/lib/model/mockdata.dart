/*
    add mocup data to firebase
  */

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

addMockupData() {
  var userList = [
    {"name": "User01", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user01.png"},
    {"name": "User02", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user02.png"},
    {"name": "User03", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user03.png"},
    {"name": "User04", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user04.png"},
    {"name": "User05", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user05.png"},
    {"name": "User06", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user06.png"},
    {"name": "User07", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/user07.png"}
  ];

  var cityList = [
    {"name": "NewYork", "country": "United State", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/city01.png"},
    {"name": "Sydney", "country": "Australia", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/city02.png"},
    {"name": "Beijing", "country": "China", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/city03.png"},
    {"name": "Chiang Mai", "country": "Thailand", "image": "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/city04.png"},
  ];

  var tripList = [
    {
      "name": "1st Time at opera house",
      "city": "australia_sydney",
      "user": "user01",
      "body":
          "Duis mollit eu veniam est dolore anim exercitation ex consectetur. Aute incididunt amet ut tempor. Quis laboris sit id in reprehenderit eiusmod. Consectetur commodo dolore sint fugiat. Consectetur aute anim incididunt nostrud pariatur. Sint ea veniam et sit reprehenderit sunt nulla nisi fugiat quis eiusmod non do. <<1>> Cupidatat aliqua aute mollit velit deserunt in laborum cillum. Incididunt labore minim reprehenderit tempor Lorem. Dolor tempor qui minim et aute veniam laboris aute nulla. <<2>> Deserunt ea commodo incididunt voluptate nulla. Culpa commodo est enim commodo. Consequat ullamco mollit adipisicing reprehenderit pariatur.",
      "image": [
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place06.png",
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place05.png",
      ],
    },
    {
      "name": "Firework at the harbor",
      "city": "australia_sydney",
      "user": "user01",
      "body":
          "Duis mollit eu veniam est dolore anim exercitation ex consectetur. Aute incididunt amet ut tempor. Quis laboris sit id in reprehenderit eiusmod. Consectetur commodo dolore sint fugiat. Consectetur aute anim incididunt nostrud pariatur. Sint ea veniam et sit reprehenderit sunt nulla nisi fugiat quis eiusmod non do. <<1>> Cupidatat aliqua aute mollit velit deserunt in laborum cillum. Incididunt labore minim reprehenderit tempor Lorem. Dolor tempor qui minim et aute veniam laboris aute nulla. <<2>> Deserunt ea commodo incididunt voluptate nulla. Culpa commodo est enim commodo. Consequat ullamco mollit adipisicing reprehenderit pariatur.",
      "image": [
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place04.png",
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place05.png"
      ]
    },
    {
      "name": "Race into the night",
      "city": "united_state_newyork",
      "user": "user02",
      "body":
          "Duis mollit eu veniam est dolore anim exercitation ex consectetur. Aute incididunt amet ut tempor. Quis laboris sit id in reprehenderit eiusmod. Consectetur commodo dolore sint fugiat. Consectetur aute anim incididunt nostrud pariatur. Sint ea veniam et sit reprehenderit sunt nulla nisi fugiat quis eiusmod non do. <<1>> Cupidatat aliqua aute mollit velit deserunt in laborum cillum. Incididunt labore minim reprehenderit tempor Lorem. Dolor tempor qui minim et aute veniam laboris aute nulla.",
      "image": [
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place01.png",
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place05.png"
      ]
    },
    {
      "name": "The Harbor",
      "city": "australia_sydney",
      "user": "user03",
      "body":
          "Duis mollit eu veniam est dolore anim exercitation ex consectetur. Aute incididunt amet ut tempor. Quis laboris sit id in reprehenderit eiusmod. Consectetur commodo dolore sint fugiat. Consectetur aute anim incididunt nostrud pariatur. Sint ea veniam et sit reprehenderit sunt nulla nisi fugiat quis eiusmod non do. <<1>> Cupidatat aliqua aute mollit velit deserunt in laborum cillum. Incididunt labore minim reprehenderit tempor Lorem. Dolor tempor qui minim et aute veniam laboris aute nulla. ",
      "image": [
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place06.png",
        "https://raw.githubusercontent.com/anoochit/flutter_aru_2021/master/04_travel_guide_full/assets/images/place05.png"
      ]
    },
  ];

  // add user
  log('firebase -> add users');
  userList.forEach((element) {
    FirebaseFirestore.instance.collection('users').doc(element['name'].toLowerCase().replaceAll(' ', '_')).set(
      {
        "name": element['name'],
        "image": element['image'],
      },
    );
  });

  // add city
  log('firebase -> add cities');
  cityList.forEach((element) {
    FirebaseFirestore.instance.collection('cities').doc(element['country'].toLowerCase().replaceAll(' ', '_') + '_' + element['name'].toLowerCase().replaceAll(' ', '_')).set(
      {
        "name": element['name'],
        "country": element['country'],
        "image": element['image'],
      },
    );
  });

  // add places
  log('firebase -> add places');
  int i = 0;
  tripList.forEach((element) {
    FirebaseFirestore.instance.collection('trips').doc('trip' + i.toString()).set(
      {
        "name": element['name'],
        "user": element['user'],
        "city": element['city'],
        "image": element['image'],
        "body": element['body'],
      },
    );
    i++;
  });
}
