import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/services/firebase_auth_service.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      Provider(
        create: (_) => FirebaseAuthService(),
      ),
      StreamProvider(
        create: (context) =>
        context.read<FirebaseAuthService>().onAuthStateChanged, initialData: null,
      ),
    ],
    child: MyApp(),
  ),
);