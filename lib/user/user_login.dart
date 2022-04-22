import 'package:bayya/user/forget_password.dart';
import 'package:bayya/user/user_register.dart';
import 'package:bayya/views/catalog/catalog_view.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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

  Widget _showPassword() {
    return IconButton(
        onPressed: () => setState(() {
              _obscurePasswordText = !_obscurePasswordText;
            }),
        icon: _obscurePasswordText
            ? const Icon(CupertinoIcons.eye_slash)
            : const Icon(CupertinoIcons.eye));
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

  Widget _forgotPassword() {
    return TextButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => const ForgetPassword());
        },
        child: const Text('Forgot password?'));
  }

  Widget _donthaveAccount() {
    return TextButton(
        onPressed: () => Navigator.push(
            context, TweenAnimationRoute().playAnimation(const UserRegister())),
        child: const Text("Don't have an account?"));
  }

  Widget _loadingWhenTap() {
    return const LinearProgressIndicator();
  }

  Widget _loginButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                        content: _loadingWhenTap(),
                      );
                    });
                // ignore: unused_local_variable
                var result = await _login()
                    .whenComplete(() => Navigator.pop(context))
                    .then((value) => Navigator.pushReplacement(context,
                        TweenAnimationRoute().playAnimation(const CatalogView())));
              }
            },
            child: const Text('Login')));
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailCtrl.text, password: _passCtrl.text);
    } on FirebaseAuthException catch (e) {
      String msg = '';
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        //print('Wrong password provided for that user.');
        msg = 'Wrong password provided for that user.';
      } else {
        //print(e.code);
        msg = e.code;
      }
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(msg));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
        title: const Text('Login'),
      ),
      body: _mainForm(),
    );
  }
}
