import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RPPView extends StatefulWidget{
  final title;
  const RPPView({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RPPView();
  }
}

class _RPPView extends State<RPPView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Text(widget.title),
    );
  }

}