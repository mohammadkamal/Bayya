import 'package:Bayya/User/AccountVistorPage.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatefulWidget {
  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  Route _createRouteToAccountVistor() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AccountVistorPage(),
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
    return ListTile(
        title: Text('Account'),
        leading: Icon(Icons.person, color: Colors.grey),
        onTap: () {
          Navigator.of(context).push(_createRouteToAccountVistor());
        });
  }
}
