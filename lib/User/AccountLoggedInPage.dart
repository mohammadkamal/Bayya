import 'package:Bayya/User/EditProfile.dart';
import 'package:Bayya/User/UserInformationTopCard.dart';
import 'package:Bayya/User/VendorAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountLoggedInPage extends StatefulWidget {
  @override
  _AccountLoggedInPageState createState() => _AccountLoggedInPageState();
}

class _AccountLoggedInPageState extends State<AccountLoggedInPage> {
  Widget _accountSettings() {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('Edit Profile'),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditProfile()));
      },
    );
  }

  Widget _signOut() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign out'),
      onTap: () {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _pageTitle = '';
    if (FirebaseAuth.instance.currentUser.displayName == null) {
      _pageTitle = FirebaseAuth.instance.currentUser.email;
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        _pageTitle = FirebaseAuth.instance.currentUser.email;
      } else {
        _pageTitle = FirebaseAuth.instance.currentUser.displayName;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: ListView(
        children: [
          UserInformationTopCard(),
          _accountSettings(),
          VendorAccount(FirebaseAuth.instance.currentUser.email,FirebaseAuth.instance.currentUser.displayName),
          _signOut()
        ],
      ),
    );
  }
}
