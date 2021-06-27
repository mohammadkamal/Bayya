import 'package:bayya/catalog/shopping_list.dart';
import 'package:bayya/user/user_login.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  bool _obscurePasswordText = true;

  Widget _email() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: _emailCtrl,
        decoration: InputDecoration(
            labelText: 'Enter your e-mail',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
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

  Widget _showPassword() {
    return IconButton(
        onPressed: () => setState(() {
              _obscurePasswordText = !_obscurePasswordText;
            }),
        icon: _obscurePasswordText
            ? Icon(CupertinoIcons.eye_slash)
            : Icon(CupertinoIcons.eye));
  }

  Widget _password() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: _passCtrl,
          decoration: InputDecoration(
              suffixIcon: _showPassword(),
              labelText: 'Enter your password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          obscureText: _obscurePasswordText,
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
            context, TweenAnimationRoute().playAnimation(UserLogin())),
        child: Text('Already hava an account?'));
  }

  Widget _submitButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
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
                    .then((value) => Navigator.pushReplacement(context,
                        TweenAnimationRoute().playAnimation(ShoppingList())));
              }
            },
            child: Text('Submit')));
  }

  Future<void> _register() async {
    String msg = '';
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCtrl.text, password: _passCtrl.text);
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
                _email(),
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
