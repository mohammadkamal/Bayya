import 'package:Bayya/User/UserLogin.dart';
import 'package:Bayya/User/UserRegister.dart';
import 'package:flutter/material.dart';

class AccountVistorPage extends StatelessWidget {
  Widget _notSignedIn() {
    return Container(
        color: Colors.blueAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    'Not logged in',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ));
  }

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
          children: [_notSignedIn(), _registerCard(context), _loginCard(context)],
        ));
  }
}
