import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/strings.dart';

class ProfileView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileView();
  }
}

class _ProfileView extends State<ProfileView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.profile),
      ),
    );
  }
}

