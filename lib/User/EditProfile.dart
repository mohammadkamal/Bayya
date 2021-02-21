import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayNameCtrl = TextEditingController();

  Widget _displayName() {
    String name = '';
    // Null bug from FirebaseAuth
    if (FirebaseAuth.instance.currentUser.displayName == null) {
      print('firebase null bug');
      name = 'User name is not available';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        name = 'User name is empty';
      } else {
        name = FirebaseAuth.instance.currentUser.displayName;
      }
    }
    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User name',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: _displayNameForm(),
                );
              });
        },
      ),
    );
  }

  Widget _displayNameForm() {
    TextEditingController userCtrl = TextEditingController();
    return Form(
        child: ListView(
      children: [
        Text('New user name:'),
        TextFormField(
          controller: userCtrl,
        ),
        ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: LinearProgressIndicator(),
                    );
                  });
              FirebaseAuth.instance.currentUser
                  .updateProfile(displayName: userCtrl.text)
                  .whenComplete(() {Navigator.pop(context);})
                  .catchError((error) => print(error));
            })
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: [_displayName()],
      ),
    );
  }
}
