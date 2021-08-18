import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';

class Verify {
  static Timer _timer;
  static Duration _countdown;

  static String getStringCountdown() {
    return _countdown.toString().substring(2, 7);
  }

  static void verify(context, Function callback) {
    print("Verification Listener Start");
    Utils.showSnackbar(context, Strings.resendVerification);
    FirebaseAuthService().sendEmailVerification().then((value) {
      _countdown = Duration(minutes: 3);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _countdown -= Duration(seconds: 1);
        if (timer.tick % 5 == 0) {
          FirebaseAuthService().verify().then((value) {
            print(value.verified);
            if (value.verified) {
              _timer.cancel();
              _countdown = Duration(seconds: 0);
              Utils.showSnackbar(context, Strings.emailVerified);
              print("Verification Listener Finish, Verified");
              if(callback!=null){
                callback.call();
              }
            }
          });
        }
        if (_countdown.isNegative) {
          _timer.cancel();
          print("Verification Listener Timeout");
        }
      });
    }).catchError((e){
      print(e);
      Utils.showSnackbar(context, Strings.errorCannotSendEmail);
    });
  }

  static bool check(context, {dontShow = false, Function callback}) {
    if (_timer != null && _timer.isActive) {
      Utils.showSnackbar(
          context,
          Strings.waitToVerify +
              ", " +
              Strings.timeout +
              " : " +
              getStringCountdown());
      return false;
    } else if (!FirebaseAuthService().currentUser().verified &&
        (_timer == null || !_timer.isActive)) {
      final snackBar = SnackBar(
        content: Text(Strings.emailNotVerified),
        action: SnackBarAction(
          label: Strings.sendVerification,
          onPressed: () {
            verify(context, callback);
          },
        ),
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    } else {
      if (!dontShow) Utils.showSnackbar(context, Strings.emailVerified);
      print("Account is Verified");
      return true;
    }
  }
}
