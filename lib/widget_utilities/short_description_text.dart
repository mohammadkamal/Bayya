import 'package:flutter/material.dart';

class ShortDescriptionText extends StatelessWidget
{
  final String shortDescription;
  final double bottomPadding;

  const ShortDescriptionText({Key key, this.shortDescription, this.bottomPadding}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      width: 190,
      child: Text(
        shortDescription,
        softWrap: true,
      ),
    );
  }
}