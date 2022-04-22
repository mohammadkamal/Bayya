import 'package:bayya/user/edit_profile.dart';
import 'package:bayya/user/user_information_top_card.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountLoggedInPage extends StatefulWidget {
  const AccountLoggedInPage({Key key}) : super(key: key);

  @override
  _AccountLoggedInPageState createState() => _AccountLoggedInPageState();
}

class _AccountLoggedInPageState extends State<AccountLoggedInPage> {
  Widget _accountSettings() {
    return ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Edit Profile'),
        onTap: () => Navigator.push(
            context, TweenAnimationRoute().playAnimation(const EditProfile())));
  }

  Widget _signOut() {
    return ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const Text('Sign out'),
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
        children: [const UserInformationTopCard(), _accountSettings(), _signOut()],
      ),
    );
  }
}
