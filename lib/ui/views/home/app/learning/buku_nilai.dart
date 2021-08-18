import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer_content.dart';

class ScoringBookView extends StatefulWidget{
  final title;
  const ScoringBookView({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ScoringBookView();
  }
}

class _ScoringBookView extends State<ScoringBookView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Text(widget.title),
    );
  }

}