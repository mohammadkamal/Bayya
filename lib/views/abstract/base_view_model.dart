import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  //final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBarMessage(context, message) {
    final snackBar = SnackBar(
      content: Text((message ?? 'Error occured!').toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
