import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInformationTopCard extends StatelessWidget {
  const UserInformationTopCard({Key key}) : super(key: key);

  String _checkLoggedUserName() {
    String temp = 'Not signed in';

    if (FirebaseAuth.instance.currentUser == null ||
        FirebaseAuth.instance.currentUser.isAnonymous) {
      temp = 'Not signed in';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName == null) {
        temp = FirebaseAuth.instance.currentUser.email;
      } else {
        if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
          temp = FirebaseAuth.instance.currentUser.email;
        } else {
          temp = FirebaseAuth.instance.currentUser.displayName;
        }
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _checkLoggedUserName(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
