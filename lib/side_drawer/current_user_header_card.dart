import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserHeaderCard extends StatefulWidget {
  @override
  _CurrentUserHeaderCardState createState() => _CurrentUserHeaderCardState();
}

class _CurrentUserHeaderCardState extends State<CurrentUserHeaderCard> {
  String userNameLabel = 'Vistor';

  @override
  Widget build(BuildContext context) {
    //Known bug at firebase_core0.7.0 --> Upgrade to nullsafety
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null || user.isAnonymous) {
        userNameLabel = 'Vistor';
      } else {
        if (user.displayName.isEmpty) {
          userNameLabel = 'User Name not specifed';
        } else {
          userNameLabel = user.displayName;
        }
      }
    });

    /*FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        userNameLabel = 'Vistor';
      } else {
        if (user.displayName.isEmpty) {
          userNameLabel = 'User Name not specifed';
        } else {
          userNameLabel = user.displayName;
        }
      }
      setState(() {});

      if (FirebaseAuth.instance.currentUser.displayName == null) {
      userNameLabel = 'User Name not specifed';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        userNameLabel = 'User Name not specifed';
      } else {
        userNameLabel = FirebaseAuth.instance.currentUser.displayName;
      }
    }
    });*/
    return DrawerHeader(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Icon(Icons.person_outline_rounded, size: 50))
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(userNameLabel, softWrap: true)]),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
