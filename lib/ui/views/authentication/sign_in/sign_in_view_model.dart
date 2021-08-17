import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../app/services/firebase_auth_service.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel(this.locator);

  final Locator locator;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
}