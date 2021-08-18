import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/strings.dart';
import 'package:gmdapp/app/services/firebase_auth_service.dart';
import 'package:gmdapp/app/utils/utils.dart';
import 'package:gmdapp/ui/views/home/home_view.dart';

class Verify {
  static Timer _timer = Timer(Duration(seconds: 0), () {});
  static Duration _countdown = Duration(seconds: 0);

  static String getStringCountdown() {
    return _countdown.toString().substring(2, 7);
  }

  static bool check(context, {time = 0}) {
    if(_timer.isActive){
      Utils.showScaffold(context, Strings.waitToVerify + ", " + Strings.timeout + " : " + getStringCountdown());
      return false;
    }
    else if (!FirebaseAuthService().currentUser().verified && (!_timer.isActive)) {
      Timer(Duration(seconds: time), () {
        final snackBar = SnackBar(
          content: Text(Strings.emailNotVerified),
          action: SnackBarAction(
            label: Strings.sendVerification,
            onPressed: () {
              print("Verification Listener Start");
              _countdown = Duration(minutes: 3);
              _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                _countdown -= Duration(seconds: 1);
                if (timer.tick % 5 == 0) {
                  FirebaseAuthService().user.reload().then((value) {
                    print(FirebaseAuthService().user.emailVerified);
                    if (FirebaseAuthService().user.emailVerified) {
                      _timer.cancel();
                      _countdown = Duration(seconds: 0);
                      Utils.showScaffold(context, Strings.emailVerified);
                      print("Verification Listener Finish, Verified");
                    }
                  });
                }
                if (_countdown.isNegative) {
                  _timer.cancel();
                  print("Verification Listener Timeout");
                }
              });
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      return false;
    } else {
      print("Account is Verified");
      return true;
    }
  }
}
