import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningRegistratorView extends StatefulWidget{
  final title;
  const LearningRegistratorView({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LearningRegistratorView();
  }
}

class _LearningRegistratorView extends State<LearningRegistratorView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Text(widget.title),
    );
  }

}