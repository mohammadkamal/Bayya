import 'package:flutter/material.dart';

import '../../../user/user_login.dart';
import '../styles/tween_animation_route.dart';

class SignInToPerfomAction extends StatelessWidget {
  const SignInToPerfomAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unallowed action'),
      content: const Text(
        'You are not signed in currently. Please sign in to perform this action.',
        softWrap: true,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.push(
                context, TweenAnimationRoute().playAnimation(const UserLogin())),
            child: const Text('Sign in')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('Cancel'))
      ],
    );
  }
}
