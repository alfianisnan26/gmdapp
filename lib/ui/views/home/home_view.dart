import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/utils/verificator.dart';
import 'package:provider/provider.dart';

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
    super.initState();
    Verify.check(context, time: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Home Page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Verify.check(context);
              },
              child: Text(Strings.verify),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthService>().signOut();
              },
              child: Text(Strings.signOut),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}