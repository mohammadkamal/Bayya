import 'package:bayya/user/user_information_top_card.dart';
import 'package:bayya/user/user_login.dart';
import 'package:bayya/user/user_register.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';

class AccountVisitorPage extends StatefulWidget {
  const AccountVisitorPage({Key key}) : super(key: key);

  @override
  _AccountVisitorPageState createState() => _AccountVisitorPageState();
}

class _AccountVisitorPageState extends State<AccountVisitorPage> {
  Widget _registerCard() {
    return ListTile(
      leading: const Icon(Icons.person_add),
      title: const Text('Register'),
      onTap: () => Navigator.push(
          context, TweenAnimationRoute().playAnimation(const UserRegister())),
    );
  }

  Widget _loginCard() {
    return ListTile(
      leading: const Icon(Icons.lock_open),
      title: const Text('Login'),
      onTap: () => Navigator.push(
          context, TweenAnimationRoute().playAnimation(const UserLogin())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
        ),
        body: ListView(
          children: [const UserInformationTopCard(), _registerCard(), _loginCard()],
        ));
  }
}
