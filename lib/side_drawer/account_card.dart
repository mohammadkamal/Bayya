import 'package:bayya/user/account_logged_in_page.dart';
import 'package:bayya/user/account_visitor_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatefulWidget {
  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  Route _createRouteToAccountVistor() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AccountVisitorPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  Route _createRouteToLoggedInAccount() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AccountLoggedInPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges();
    return ListTile(
        title: Text('Account'),
        leading: Icon(Icons.person, color: Colors.grey),
        onTap: () {
          if (FirebaseAuth.instance.currentUser == null ||
              FirebaseAuth.instance.currentUser.isAnonymous) {
            Navigator.of(context).push(_createRouteToAccountVistor());
          } else {
            Navigator.of(context).push(_createRouteToLoggedInAccount());
          }
        });
  }
}
