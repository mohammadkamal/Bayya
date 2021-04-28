import 'package:bayya/user/vendors_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _displayName = '';
  TextEditingController _displayNameCtrl;
  bool _isVendor = false;
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    // Null bug from FirebaseAuth
    if (FirebaseAuth.instance.currentUser.displayName == null) {
      print('firebase null bug');
      _displayName = 'User name is not available';
    } else {
      if (FirebaseAuth.instance.currentUser.displayName.isEmpty) {
        _displayName = 'User name is empty';
      } else {
        _displayName = FirebaseAuth.instance.currentUser.displayName;
      }
    }
    _displayNameCtrl = TextEditingController(text: _displayName);
    _checkIfVendor();
  }

  Future<void> _checkIfVendor() async {
    var _result = await context
        .read<VendorsList>()
        .isVendorAccount(FirebaseAuth.instance.currentUser.uid);
    if (_result == true && _isVendor == false) {
      setState(() {
        _isVendor = _result;
      });
    }
  }

  Widget _displayNameTile() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User name',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            _displayName,
          )
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
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
        padding: EdgeInsets.only(left: 5, bottom: 5),
        child: Text(
          'New display name:',
          softWrap: true,
        ));
  }

  Widget _displayNameTextForm() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 7))),
      controller: _displayNameCtrl,
    );
  }

  Widget _displayNameUpdateButton() {
    return ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.currentUser
              .updateProfile(displayName: _displayNameCtrl.text).then((value) => Navigator.pop(context));
          if (_isVendor) {
            context.read<VendorsList>().updateDisplayName(
                FirebaseAuth.instance.currentUser.uid, _displayNameCtrl.text);
          }
        },
        child: Text('Update'));
  }

  Widget _displayNameCanelButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Cancel'),
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
        _displayNameUpdateButton(),
        _displayNameCanelButton()
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: [_displayNameTile()],
      ),
    );
  }
}
