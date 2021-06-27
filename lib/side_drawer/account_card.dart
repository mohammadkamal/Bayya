import 'package:bayya/user/account_logged_in_page.dart';
import 'package:bayya/user/account_visitor_page.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatefulWidget {
  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges();
    return ListTile(
        title: Text('Account'),
        leading: Icon(Icons.person, color: Colors.grey),
        onTap: () {
          if (FirebaseAuth.instance.currentUser == null ||
              FirebaseAuth.instance.currentUser.isAnonymous) {
            Navigator.of(context).push(
                TweenAnimationRoute().playAnimation(AccountVisitorPage()));
          } else {
            Navigator.of(context).push(
                TweenAnimationRoute().playAnimation(AccountLoggedInPage()));
          }
        });
  }
}
