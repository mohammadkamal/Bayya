import 'package:Bayya/User/UserInfoLabelForm.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
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

  Widget _forgotPassword() {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      onTap: () {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  child: Text('Enter your e-mail'),
                ),
              );
            });
      },
    );
  }

  Widget _loginButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {}
            },
            child: Text('Login')));
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
              _forgotPassword(),
              _loginButton()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _mainForm(),
    );
  }
}
