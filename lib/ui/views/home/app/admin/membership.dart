import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MembershipView extends StatefulWidget{
  final title;
  const MembershipView({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MembershipView();
  }
}

class _MembershipView extends State<MembershipView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Text(widget.title),
    );
  }

}