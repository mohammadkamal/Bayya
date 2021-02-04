import 'package:flutter/material.dart';

class UserInfoLabelForm extends StatelessWidget {
  final String text;

  const UserInfoLabelForm({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Text(text)],
      ),
    );
  }
}
