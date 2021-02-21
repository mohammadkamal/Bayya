import 'package:Bayya/User/UserInformationTopCard.dart';
import 'package:Bayya/User/UserLogin.dart';
import 'package:Bayya/User/UserRegister.dart';
import 'package:flutter/material.dart';

class AccountVistorPage extends StatefulWidget {
  @override
  _AccountVistorPageState createState() => _AccountVistorPageState();
}

class _AccountVistorPageState extends State<AccountVistorPage> {
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
