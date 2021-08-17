import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.verified
  });

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  final bool verified;
}