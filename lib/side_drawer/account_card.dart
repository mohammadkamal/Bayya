import 'package:bayya/user/account_logged_in_page.dart';
import 'package:bayya/user/account_visitor_page.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text('Account'),
        leading: const Icon(Icons.person, color: Colors.grey),
        onTap: () {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.of(context).push(
                TweenAnimationRoute().playAnimation(const AccountVisitorPage()));
          } else {
            Navigator.of(context).push(
                TweenAnimationRoute().playAnimation(const AccountLoggedInPage()));
          }
        });
  }
}
