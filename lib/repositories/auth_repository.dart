import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'base/base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _google;

  AuthRepository(this._auth, this._google);

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<void> signin(UserModel user) async {
    await _auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  @override
  Future<void> signup(UserModel user) async {
    await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  @override
  Future<bool> continueWithGoogle() async {
    final account = await _google.signIn();
    if (account == null) return false;

    final googleAuth = await account.authentication;
    final credits = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credits);
    return true;
  }

  @override
  Future<void> signout() async {
    await _google.signOut();
    await _auth.signOut();
  }
}
