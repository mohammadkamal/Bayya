import 'package:Bayya/User/UserInfoLabelForm.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();

  Widget _userName() {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
          decoration: InputDecoration(
            border: null,
            labelText: 'Enter your username',
          ),
          autofocus: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ));
  }

  Widget _password() {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Enter your password'),
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ));
  }

  Widget _confirmPassword() {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Re-enter your password'),
          validator: (value) {
            if (value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ));
  }

  Widget _email() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Enter your e-mail'),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _submitButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {}
            },
            child: Text('Submit')));
  }

  Widget _mainForm() {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                UserInfoLabelForm(text: 'Username:'),
                _userName(),
                UserInfoLabelForm(text: 'Password'),
                _password(),
                UserInfoLabelForm(text: 'Confirm password'),
                _confirmPassword(),
                UserInfoLabelForm(text: 'E-mail:'),
                _email(),
                _submitButton(),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register a new user'),
      ),
      body: _mainForm(),
    );
  }
}
