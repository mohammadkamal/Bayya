import 'package:bayya/user/account_logged_in_page.dart';
import 'package:bayya/user/account_visitor_page.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Account'),
        leading: Icon(Icons.person, color: Colors.grey),
        onTap: () {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.of(context).push(
                TweenAnimationRoute().playAnimation(AccountVisitorPage()));
          } else {
            Navigator.of(context).push(
                TweenAnimationRoute().playAnimation(AccountLoggedInPage()));
          }
        });
  }
}
