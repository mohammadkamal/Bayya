import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKeyL = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();

  Widget _emailForm() {
    return TextFormField(
      controller: _emailCtrl,
      decoration: InputDecoration(
          labelText: 'Enter your email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
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
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
            onPressed: () {
              if (_formKeyL.currentState.validate()) {
                _reset();
              }
            },
            child: Text('Confirm')));
  }

  Future<void> _reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Reset password'),
        content: ListView(shrinkWrap: true, children: [
          Form(
            key: _formKeyL,
            child: Column(
              children: [_emailForm(), _resetButton()],
            ),
          ),
        ]));
  }
}
