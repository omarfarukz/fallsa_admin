import 'package:flutter/material.dart';

class CText extends StatelessWidget {

  final text;
  const CText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
