import 'package:bayya/user/forget_password.dart';
import 'package:bayya/user/user_info_label_form.dart';
import 'package:bayya/user/user_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  Widget _email() {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextFormField(
          controller: emailCtrl,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(width: 7)),
            labelText: 'Enter your email',
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
          controller: passCtrl,
          decoration: InputDecoration(
              labelText: 'Enter your password',
              border: OutlineInputBorder(borderSide: BorderSide(width: 7))),
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
    return TextButton(
        onPressed: () {
          return showDialog(
              context: context, builder: (context) => ForgetPassword());
        },
        child: Text('Forgot password?'));
  }

  Widget _donthaveAccount() {
    return TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserRegister())),
        child: Text("Don't have an account?"));
  }

  Widget _loadingWhenTap() {
    return Container(child: LinearProgressIndicator());
  }

  Widget _loginButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: _loadingWhenTap(),
                      );
                    });
                // ignore: unused_local_variable
                var result = await _login()
                    .whenComplete(() => Navigator.pop(context))
                    .then((value) =>
                        Navigator.popUntil(context, ModalRoute.withName('/')));
              }
            },
            child: Text('Login')));
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtrl.text, password: passCtrl.text);
    } on FirebaseAuthException catch (e) {
      String msg = '';
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        msg = 'Wrong password provided for that user.';
      } else {
        print(e.code);
        msg = e.code;
      }
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Container(child: Text(msg)));
          });
    }
  }

  Widget _mainForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              UserInfoLabelForm(text: 'Email:'),
              _email(),
              UserInfoLabelForm(text: 'Password'),
              _password(),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [_donthaveAccount(), _forgotPassword()],
              ),
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
