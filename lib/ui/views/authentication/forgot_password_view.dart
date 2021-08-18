import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/assets.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';
import 'package:gmdapp/ui/views/authentication/sign_in/sign_in_view_model.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: ForgotPasswordViewBody._(),
        );
      },
    );
  }
}

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody._({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordView();
  }
}

class _ForgotPasswordView extends State<ForgotPasswordViewBody> {
  TextEditingController _email = TextEditingController();
  bool _forgetButtonState = false;
  Widget _forgetButtonChild(bool state) => (state)
      ? Container(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ))
      : Text(Strings.sendVerification);
  Color _color(bool state) => (state) ? Colors.blue : Colors.red;
  bool _validState = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(Assets.links.images.bgLogin),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.5)),
                  child: Image.asset(Assets.links.images.logo),
                ),
                Container(
                    width: (size.width > 400) ? 400 : size.width,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: Theme(
                        data: ThemeData(
                            primaryColor: _color(_validState),
                            primaryColorDark: _color(_validState)),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              _validState = Utils.emailValidate(val);
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          controller: _email,
                          enableSuggestions: true,
                          autocorrect: true,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: Strings.email,
                              fillColor: Colors.white.withOpacity(0.5)),
                        ))),
                Container(
                  height: 60,
                  width: (size.width > 400) ? 400 : size.width,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    onPressed: (_forgetButtonState)? null : () async {
                      FocusScope.of(context).unfocus();
                      if(_validState == false){
                        Utils.showScaffold(context, Strings.errorEmailInvalid);
                      }else{
                        setState(() {
                          _forgetButtonState = true;
                        });
                        context.read<FirebaseAuthService>().forgotPassword(_email.text).then((value){
                          final snackBar = SnackBar(
                            content: Text(Strings.resetEmailSent),
                            action: SnackBarAction(
                              label: Strings.back,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }).catchError((e){
                          if(e.toString().contains('user-not-found')){
                            Utils.showScaffold(context, Strings.userNotFound);
                          }else{
                            print(e.toString());
                            Utils.showScaffold(context, Strings.errorCannotSendEmail);
                          }
                        }).then((value) => setState(() {
                          _forgetButtonState = true;
                        }));
                      }
                    },
                    child: _forgetButtonChild(_forgetButtonState)
                  ),
                ),
                Container(
                  width: (size.width > 400) ? 400 : size.width,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Center(child: footerLink(context)),
                ),
              ]),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                Strings.footer,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ))
        ],
      ),
    ));
  }
}

Widget footerLink(BuildContext context) {
  TextStyle defaultStyle = TextStyle(
      color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold);
  TextStyle linkStyle =
      TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
  return RichText(
    text: TextSpan(
      style: defaultStyle,
      children: <TextSpan>[
        TextSpan(
            text: Strings.back,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pop();
              }),
      ],
    ),
  );
}
