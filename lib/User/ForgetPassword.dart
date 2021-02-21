import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKeyL = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();

  Widget _mainText() {
    return Container(
        child: Text('Please insert your email address', softWrap: true));
  }

  Widget _emailForm() {
    return TextFormField(
      controller: emailCtrl,
      decoration: InputDecoration(labelText: 'Enter your email'),
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is required';
        }
        if (!value.contains('@')) {
          return 'Must contain @';
        }
        return null;
      },
    );
  }

  Widget _resetButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
            onPressed: () {
              if (_formKeyL.currentState.validate()) {
                _reset();
              }
            },
            child: Text('Reset Password')));
  }

  Future<void> _reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
            child: Form(
      key: _formKeyL,
      child: Center(
        child: Column(
          children: [_mainText(), _emailForm(), _resetButton()],
        ),
      ),
    )));
  }
}