import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/strings.dart';

class SettingView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SettingView();
  }
}

class _SettingView extends State<SettingView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.setting),
      ),
    );
  }
}

