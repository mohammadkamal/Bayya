import 'package:bayya/user/user_login.dart';
import 'package:flutter/material.dart';

class SignInToPerfomAction extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Unallowed action'),
      content: Text(
        'You are not signed in currently. Please sign in to perform this action.',
        softWrap: true,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserLogin())),
            child: Text('Sign in')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel'))
      ],
    );
  }
  
}