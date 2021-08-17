import 'dart:core';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/assets.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';
import 'package:gmdapp/ui/views/authentication/forgot_password_view.dart';
import 'package:gmdapp/ui/views/authentication/sign_up_view.dart';
import 'package:provider/provider.dart';

import 'sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: SignInViewBody._(),
        );
      },
    );
  }
}

class SignInViewBody extends StatefulWidget {
  const SignInViewBody._({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SignInViewBody();
  }
}

class _SignInViewBody extends State<SignInViewBody> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _signInButtonState = false;
  Widget _signInButtonChild(bool state) => (state)
      ? Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ))
      : Text(Strings.login);
  Color _color(bool state) => (state) ? Colors.blue : Colors.red;
  bool _validState = false;
  bool _obsState = false;
  IconData _icon(bool state) =>
      (state) ? Icons.remove_red_eye : Icons.remove_red_eye_outlined;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
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
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 50, bottom: 10),
                    child: Theme(
                        data: ThemeData(
                            primaryColor: _color(_validState),
                            primaryColorDark: _color(_validState)),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            setState(() {
                              _validState = Utils.emailValidate(val);
                            });
                          },
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
                    width: (size.width > 400) ? 400 : size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(alignment: Alignment.centerRight, children: [
                      TextField(
                        controller: _password,
                        obscureText: !_obsState,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 20, right: 50, top: 20, bottom: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: Strings.pass,
                            fillColor: Colors.white.withOpacity(0.5)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: IconButton(
                              icon: Icon(_icon(_obsState)),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _obsState = !_obsState;
                                });
                              })),
                    ])),
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
                    onPressed: (_signInButtonState)
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            if (_validState == false)
                              Utils.showScaffold(
                                  context, Strings.errorEmailInvalid);
                            else {
                              setState(() {
                                _signInButtonState = true;
                              });
                              context
                                  .read<FirebaseAuthService>()
                                  .signInWithEmail(_email.text, _password.text)
                                  .catchError((e) {
                                setState(() {
                                  _signInButtonState = false;
                                });
                                if (e
                                    .toString()
                                    .contains("email-not-verified")) {
                                  Utils.showScaffold(
                                      context, Strings.emailNotVerified);
                                } else {
                                  Utils.showScaffold(
                                      context, Strings.errorCannotLogin);
                                }
                              });
                            }
                          },
                    child: _signInButtonChild(_signInButtonState),
                  ),
                ),
                Stack(alignment: Alignment.centerLeft, children: [
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
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<FirebaseAuthService>().signInWithGoogle();
                      },
                      child: Text(Strings.signWithGoogle),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.5)),
                        child: Image.asset(Assets.links.images.googleLogo),
                      )),
                ]),
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
    );
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
            text: Strings.signup,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpView()));
              }),
        TextSpan(text: ' | ', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(
            text: Strings.forgetPassword,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordView()));
              }),
      ],
    ),
  );
}
