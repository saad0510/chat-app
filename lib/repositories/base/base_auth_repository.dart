import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

abstract class BaseAuthRepository {
  User? get currentUser;

  Stream<User?> get authStateChanges;

  Future<void> signin(UserModel user);

  Future<void> signup(UserModel user);

  Future<bool> continueWithGoogle();

  Future<void> signout();
}
