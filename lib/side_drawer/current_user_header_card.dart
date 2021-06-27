import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserHeaderCard extends StatefulWidget {
  @override
  _CurrentUserHeaderCardState createState() => _CurrentUserHeaderCardState();
}

class _CurrentUserHeaderCardState extends State<CurrentUserHeaderCard> {
  String _userNameLabel = 'Vistor';

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null ||
        FirebaseAuth.instance.currentUser.isAnonymous) {
      _userNameLabel = 'Visitor';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        _userNameLabel = 'User Name not specifed';
      } else {
        _userNameLabel = FirebaseAuth.instance.currentUser.displayName;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                children: [Text(_userNameLabel, softWrap: true)]),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
