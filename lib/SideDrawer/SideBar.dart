import 'package:Bayya/SideDrawer/AccountCard.dart';
import 'package:Bayya/SideDrawer/CurrentUserHeaderCard.dart';
import 'package:Bayya/SideDrawer/ShoppingCartCard.dart';
import 'package:Bayya/SideDrawer/WatchlistCard.dart';
import 'package:Bayya/User/VendorsList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSideBar extends StatefulWidget {
  @override
  _AppSideBarState createState() => _AppSideBarState();
}

class _AppSideBarState extends State<AppSideBar> {
  bool _isVendor = false;

  Widget _products() {
    return ListTile(leading: Icon(Icons.shopping_bag), title: Text('Products'));
  }

  Future<void> _checkIfVendor() async {
    var _result = await Provider.of<VendorsList>(context)
        .isVendorAccount(FirebaseAuth.instance.currentUser.uid);
    print(_result);
    if (_result == true && _isVendor == false) {
      setState(() {
        _isVendor = _result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIfVendor();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CurrentUserHeaderCard(),
          ShoppingCartCard(),
          WatchlistCard(),
          AccountCard(),
          _isVendor ? _products() : Container()
        ],
      ),
    );
  }
}
