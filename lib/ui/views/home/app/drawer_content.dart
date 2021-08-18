import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/ui/views/home/app/admin/attendance.dart';
import 'package:gmdapp/ui/views/home/app/learning/buku_nilai.dart';

import 'admin/learningRegistrator.dart';
import 'admin/membership.dart';
import 'learning/rpp.dart';


class DrawerApp{
  static List<AppScreen> app = [
    AppScreen(app: RPPView(title: Strings.lessonPlan), title: Strings.lessonPlan,),
    AppScreen(app: ScoringBookView(title: Strings.scoringBook,), title: Strings.scoringBook,)];
  static List<Widget> widget(context) => List.generate(app.length, (index){
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => app[index])),
      child: Text(app[index].title, textAlign: TextAlign.center,))
    );
  });
}

class DrawerAdmin{
  static List<AppScreen> app = [
    AppScreen(app: AttendanceView(title: Strings.attendance), title: Strings.attendance,),
    AppScreen(app: MembershipView(title: Strings.membership,), title: Strings.membership),
    AppScreen(app: LearningRegistratorView(title: Strings.villageTeaching,), title: Strings.villageTeaching)];
  static List<Widget> widget(context) => List.generate(app.length, (index){
    return Padding(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => app[index])),
            child: Text(app[index].title, textAlign: TextAlign.center,))
    );
  });
}

class AppScreen extends StatelessWidget{
  final StatefulWidget app;
  final title;
  const AppScreen({Key key, this.app, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return app;
  }
}