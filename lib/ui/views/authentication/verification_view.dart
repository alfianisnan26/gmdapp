import 'package:flutter/material.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/ui/views/authentication/sign_in/sign_in_view_model.dart';
import 'package:provider/provider.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: VerificationViewBody._(),
        );
      },
    );
  }
}

class VerificationViewBody extends StatefulWidget{
  const VerificationViewBody._({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VerificationView();
  }
}

class _VerificationView extends State<VerificationViewBody>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Text("You Must Verify your Email!"),
          ElevatedButton(onPressed: () => context.read<FirebaseAuthService>().signOut(), child: Text("Back"))
    ],
    ));
  }
}