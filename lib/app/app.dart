import 'package:flutter/material.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/verificator.dart';
import 'package:provider/provider.dart';

import '../ui/views/authentication/sign_in/sign_in_view.dart';
import '../ui/views/home/home_view.dart';
import 'models/user.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerakan Mengajar Desa - Sukabumi',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (FirebaseAuthService().user == null) ? SignInView() : const HomeView()
    );
  }
}
