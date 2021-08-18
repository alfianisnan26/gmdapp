import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gmdapp/app/utils/verificator.dart';
import 'package:gmdapp/ui/views/authentication/sign_in/sign_in_view.dart';

import '../../../app/constants/strings.dart';
import '../../../app/services/firebase_auth_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView>{

  @override
  void initState() {
    print("Logged in as : " + FirebaseAuthService().currentUser().email);
    print("UID          : " + FirebaseAuthService().currentUser().uid);
    print("Display Name : " + FirebaseAuthService().currentUser().displayName.toString());
    print("Verified     : " + FirebaseAuthService().currentUser().verified.toString());
    print("PhotoURL     : " + FirebaseAuthService().currentUser().photoUrl.toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)  => Verify.check(context, dontShow: true, callback: setState));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (FirebaseAuthService().currentUser().verified)? Colors.white : Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(Strings.helloTutor)
            ),
            ListTile(
              title: Text(Strings.profile),
            ),
            ListTile(
              title: Text(Strings.setting),
            ),
            ListTile(
              title: Text(Strings.help),
            ),
            ListTile(
              enabled: !FirebaseAuthService().currentUser().verified,
              title: Text(Strings.checkVerification),
              onTap: (){
                Navigator.of(context).pop();
                if(Verify.check(context)) setState(() {});
              },
            ),
            ListTile(
              title: Text(Strings.exit),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignInView()));
                FirebaseAuthService().signOut();
                },
            ),
          ],
        )
      ),
      appBar: AppBar(title: Text(Strings.dashboard)),
      body: SingleChildScrollView()
    );
  }
}