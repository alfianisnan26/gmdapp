import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/strings.dart';

class HelpView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.help),
      ),
    );
  }

}