import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String code;
  final String message;

  AuthException({required this.code, required this.message});

  AuthException.empty([this.message = ""]) : code = "";

  AuthException.unknown([this.message = "unable to authenticate"])
      : code = "unknown-error";

  AuthException.signin([this.message = "unable to signin the account"])
      : code = "sigin-error";

  AuthException.signup([this.message = "unable to create an account"])
      : code = "signup-error";

  AuthException.google([this.message = "unable sign in with google"])
      : code = "google-error";

  AuthException.noUser([this.message = "no user is available for authentication"])
      : code = "no-user";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthException && other.code == code && other.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;
}

extension ShortErrorMessages on FirebaseAuthException {
  String get shortMessage {
    switch (code) {
      case "invalid-email":
        return "The email is invalid";
      case "user-disabled":
        return "The account has been disabled";
      case "user-not-found":
        return "No account exits for given email";
      case "wrong-password":
        return "Wrong password or password does not exist";
      case "email-already-in-use":
        return "Email is already in use by another account";
      case "operation-not-allowed":
        return "Given operation is not allowed";
      case "weak-password":
        return "Password is weak";
      default:
        return "$code: $message";
    }
  }
}
