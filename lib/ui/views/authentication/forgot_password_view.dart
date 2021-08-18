import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/assets.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordView();
  }
}

class _ForgotPasswordView extends State<ForgotPasswordView> {
  TextEditingController _email = TextEditingController();

  static Timer _timer;
  static Duration _duration;
  static Duration _lastDuration;
  Timer _timerObj;

  Color _color(bool state) => (state) ? Colors.blue : Colors.red;
  bool _validState = false;

  void startLocalTimer() {
    _timerObj = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (_timer == null) {
        _timerObj.cancel();
        _timerObj = null;
      }
    });
  }

  @override
  void initState() {
    if (_timer != null) startLocalTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_timerObj != null) _timerObj.cancel();
    super.dispose();
  }

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
                      onPressed: (_timer != null)
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (_validState == false) {
                                Utils.showSnackbar(
                                    context, Strings.errorEmailInvalid);
                              } else {
                                context
                                    .read<FirebaseAuthService>()
                                    .forgotPassword(_email.text)
                                    .then((value) {
                                  final snackBar = SnackBar(
                                    content: Text(Strings.resetEmailSent),
                                    action: SnackBarAction(
                                      label: Strings.back,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  _duration = Duration(minutes: 3);
                                  _timer = Timer.periodic(Duration(seconds: 1),
                                      (timer) {
                                    _duration -= Duration(seconds: 1);
                                    if (_duration.isNegative) {
                                      _timer.cancel();
                                      _timer = null;
                                    }
                                  });
                                  startLocalTimer();
                                }).catchError((e) {
                                  if (e.toString().contains('user-not-found')) {
                                    Utils.showSnackbar(
                                        context, Strings.userNotFound);
                                  } else {
                                    print(e.toString());
                                    Utils.showSnackbar(
                                        context, Strings.errorCannotSendEmail);
                                  }
                                });
                              }
                            },
                      child: (_timer == null)
                          ? Text(Strings.verify)
                          : Text(
                              _duration.toString().substring(3, 7),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            )),
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
