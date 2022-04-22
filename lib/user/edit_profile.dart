import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _displayName = '';
  TextEditingController _displayNameCtrl;
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Null bug from FirebaseAuth
    if (FirebaseAuth.instance.currentUser.displayName == null) {
      //print('firebase null bug');
      _displayName = 'User name is not available';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        _displayName = 'User name is empty';
      } else {
        _displayName = FirebaseAuth.instance.currentUser.displayName;
      }
    }
    _displayNameCtrl = TextEditingController(text: _displayName);
  }

  Widget _displayNameTile() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User name',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            _displayName,
          )
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          _scaffoldStateKey.currentState
              .showBottomSheet((context) => _displayNameSheet());
        },
      ),
    );
  }

  Widget _displayNameLabel() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 5, bottom: 5),
        child: const Text(
          'New display name:',
          softWrap: true,
        ));
  }

  Widget _displayNameTextForm() {
    return TextFormField(
      autofocus: true,
      decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 7))),
      controller: _displayNameCtrl,
    );
  }

  Widget _displayNameUpdateButton() {
    return ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.currentUser
              .updateDisplayName(_displayNameCtrl.text)
              .then((value) => Navigator.pop(context));
        },
        child: const Text('Update'));
  }

  Widget _displayNameCanelButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
    );
  }

  Widget _displayNameSheet() {
    return Form(
        child: ListView(
      shrinkWrap: true,
      children: [
        _displayNameLabel(),
        _displayNameTextForm(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_displayNameUpdateButton(), _displayNameCanelButton()],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        children: [_displayNameTile()],
      ),
    );
  }
}
