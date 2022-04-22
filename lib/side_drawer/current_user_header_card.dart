import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserHeaderCard extends StatelessWidget {
  String get userDisplayName {
    if (FirebaseAuth.instance.currentUser == null ||
        FirebaseAuth.instance.currentUser.isAnonymous) {
      return 'Visitor';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        return 'User Name not specifed';
      } else {
        return FirebaseAuth.instance.currentUser.displayName;
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
                children: [Text(userDisplayName, softWrap: true)]),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
