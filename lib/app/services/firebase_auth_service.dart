import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart' as App;

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  App.User _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return App.User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      verified: user.emailVerified
    );
  }

  Stream<App.User> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(_userFromFirebase);

  Future<App.User> signInWithEmail(email, password) async {
    var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    print("Sign in with EMAIL");
    return _userFromFirebase(authResult.user);
  }

  Future<void> forgotPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerification() async{
    await _firebaseAuth.currentUser.sendEmailVerification();
  }

  Future<App.User> verify()async {
    await _firebaseAuth.currentUser.reload();
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  Future<App.User> registerNewUser(String email, String password) async {
    var _result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(_result.user);
  }

  Future<App.User> signInWithGoogle() async {

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    print("Sign in with GOOGLE");
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async => _firebaseAuth.signOut();

  App.User currentUser() => _userFromFirebase(_firebaseAuth.currentUser);

  User get user => _firebaseAuth.currentUser;
}

class FAS{
  static App.User get user => FirebaseAuthService().currentUser();
  static String get displayName {
    if(user.displayName == null) return "Tutor";
    else return user.displayName;
  }
}