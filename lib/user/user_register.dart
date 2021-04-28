import 'package:bayya/user/user_info_label_form.dart';
import 'package:bayya/user/user_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  Widget _email() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: TextFormField(
        controller: emailCtrl,
        decoration: InputDecoration(
            labelText: 'Enter your e-mail',
            border: OutlineInputBorder(borderSide: BorderSide(width: 7))),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field is required';
          } else {
            if (!value.contains('@')) {
              return 'Field must contain @';
            }
          }
          return null;
        },
      ),
    );
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

  Widget _haveAccount() {
    return TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserLogin())),
        child: Text('Already hava an account?'));
  }

  Widget _submitButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(child: LinearProgressIndicator()),
                      );
                    });
                // ignore: unused_local_variable
                var result = await _register()
                    .whenComplete(() => Navigator.pop(context))
                    .then((value) =>
                        Navigator.popUntil(context, ModalRoute.withName('/')));
              }
            },
            child: Text('Submit')));
  }

  Future<void> _register() async {
    String msg = '';
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailCtrl.text, password: passCtrl.text);
      print('success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        msg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        msg = 'The account already exists for that email.';
      }
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Container(child: Text(msg)));
          });
    } catch (e) {
      print(e);
      msg = e.toString();
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
                UserInfoLabelForm(text: 'E-mail:'),
                _email(),
                UserInfoLabelForm(text: 'Password'),
                _password(),
                _haveAccount(),
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
