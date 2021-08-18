import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/assets.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';
import 'package:gmdapp/ui/views/home/home_view.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpView();
  }
}

class _SignUpView extends State<SignUpView> {
  bool _signUpButtonState = false;
  Widget _signUpButtonChild(bool state) => (state)
      ? Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ))
      : Text(Strings.signup);
  TextEditingController _email = TextEditingController();
  TextEditingController _password1 = TextEditingController();
  TextEditingController _password2 = TextEditingController();

  Color _color(bool state) => (state) ? Colors.blue : Colors.red;

  bool _obsState = false;
  bool _obsStateB = false;
  bool _validState1 = false;
  bool _validState2 = false;
  bool _validState3 = false;

  IconData _icon(bool state) =>
      (state) ? Icons.remove_red_eye : Icons.remove_red_eye_outlined;

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
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 50, bottom: 10),
                    child: Theme(
                        data: ThemeData(
                            primaryColor: _color(_validState1),
                            primaryColorDark: _color(_validState1)),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              _validState1 = Utils.emailValidate(val);
                            });
                          },
                          controller: _email,
                          enableSuggestions: true,
                          autocorrect: true,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
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
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Stack(alignment: Alignment.centerRight, children: [
                      Theme(
                          data: ThemeData(
                              primaryColor: _color(_validState2),
                              primaryColorDark: _color(_validState2)),
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                _validState2 = Utils.passwordValidate(val);
                              });
                            },
                            controller: _password1,
                            obscureText: !_obsState,
                            enableSuggestions: false,
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 50, top: 20, bottom: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: Strings.passConfirm,
                                fillColor: Colors.white.withOpacity(0.5)),
                          )),
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
                    width: (size.width > 400) ? 400 : size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(alignment: Alignment.centerRight, children: [
                      Theme(
                          data: ThemeData(
                              primaryColor: _color(_validState3),
                              primaryColorDark: _color(_validState3)),
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                if (_validState2 && val == _password1.text)
                                  _validState3 = true;
                                else
                                  _validState3 = false;
                              });
                            },
                            controller: _password2,
                            obscureText: !_obsStateB,
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
                          )),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: IconButton(
                              icon: Icon(_icon(_obsStateB)),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _obsStateB = !_obsStateB;
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
                      onPressed: (_signUpButtonState)
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (_validState1 == false) {
                                Utils.showSnackbar(
                                    context, Strings.errorEmailInvalid);
                              } else if (_validState2 == false) {
                                Utils.showSnackbar(
                                    context, Strings.errorPasswordInvalid);
                              } else if (_validState2 == false) {
                                Utils.showSnackbar(
                                    context, Strings.errorPasswordDoesNotMatch);
                              } else {
                                setState(() {
                                  _signUpButtonState = true;
                                });
                                context
                                    .read<FirebaseAuthService>()
                                    .registerNewUser(
                                        _email.text, _password2.text)
                                    .then((value) {
                                  setState(() {
                                    _signUpButtonState = false;
                                  });
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomeView()));
                                }).catchError((e) {
                                  setState(() {
                                    _signUpButtonState = false;
                                  });
                                  if (e
                                      .toString()
                                      .contains('email-already-in-use')) {
                                    Utils.showSnackbar(
                                        context, Strings.emailAlreadyInUse);
                                  } else if (e
                                      .toString()
                                      .contains('weak-password')) {
                                    Utils.showSnackbar(
                                        context, Strings.errorPasswordInvalid);
                                  } else {
                                    print(e);
                                    Utils.showSnackbar(
                                        context, Strings.errorCannotRegister);
                                  }
                                });
                              }
                            },
                      child: _signUpButtonChild(_signUpButtonState)),
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
