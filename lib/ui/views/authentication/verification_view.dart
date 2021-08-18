import 'dart:async';
import 'dart:html';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/assets.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';
import 'package:gmdapp/ui/views/home/home_view.dart';
import 'package:provider/provider.dart';


class VerificationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerificationView();
  }
}

class _VerificationView extends State<VerificationView> {
  static Timer timer;
  Duration countdown;
  String _resendString = Strings.sendVerification;

  @override
  void initState() {
    if(timer!=null){
      _resendString = countdown.toString().substring(2, 7);
    }
    else _resendString = Strings.sendVerification;
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null && timer.isActive) timer.cancel();
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
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      Strings.unverifyInfo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                Container(
                  height: 60,
                  width: (size.width > 400) ? 400 : size.width,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ElevatedButton(
                      autofocus: true,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: (_resendString != Strings.sendVerification)
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<FirebaseAuthService>()
                                  .sendEmailVerification()
                                  .then((value) => Utils.showScaffold(
                                      context, Strings.resendVerification));
                              countdown = Duration(minutes: 3);
                              timer =
                                  Timer.periodic(Duration(seconds: 1), (timer) {
                                if (timer.tick % 5 == 0)
                                  context
                                      .read<FirebaseAuthService>()
                                      .verify()
                                      .then((value) {
                                    print(value.verified);
                                    if (value.verified) {
                                      if (timer != null && timer.isActive)
                                        timer.cancel();
                                      _resendString = Strings.sendVerification;
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeView()));
                                    }
                                  });
                                setState(() {
                                  _resendString =
                                      countdown.toString().substring(2, 7);
                                });
                                countdown -= Duration(seconds: 1);
                                if (countdown.isNegative) {
                                  timer.cancel();
                                  _resendString = Strings.sendVerification;
                                }
                              });
                            },
                      child: Text(
                        _resendString,
                        style: TextStyle(
                            color: (_resendString != Strings.sendVerification)
                                ? Colors.white.withOpacity(0.5)
                                : Colors.white),
                      )),
                ),
                Container(
                  width: (size.width > 400) ? 400 : size.width,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Center(child: footerLink(context, timer)),
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

Widget footerLink(BuildContext context, timer) {
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
                if (timer != null && timer.isActive) timer.cancel();
                context.read<FirebaseAuthService>().signOut();
              }),
      ],
    ),
  );
}
