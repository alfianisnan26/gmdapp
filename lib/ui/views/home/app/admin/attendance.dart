import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendanceView extends StatefulWidget{
  final title;
  const AttendanceView({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AttendanceView();
  }
}

class _AttendanceView extends State<AttendanceView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Text(widget.title),
    );
  }

}