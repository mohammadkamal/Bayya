import 'package:bayya/user/user_information_top_card.dart';
import 'package:bayya/user/user_login.dart';
import 'package:bayya/user/user_register.dart';
import 'package:flutter/material.dart';

class AccountVisitorPage extends StatefulWidget {
  @override
  _AccountVisitorPageState createState() => _AccountVisitorPageState();
}

class _AccountVisitorPageState extends State<AccountVisitorPage> {
  Widget _registerCard(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person_add),
      title: Text('Register'),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserRegister()));
      },
    );
  }

  Widget _loginCard(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.lock_open),
      title: Text('Login'),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserLogin()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Account'),
        ),
        body: ListView(
          children: [
            UserInformationTopCard(),
            _registerCard(context),
            _loginCard(context)
          ],
        ));
  }
}
