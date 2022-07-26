import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/auth_exception.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

/// note: you may need to refresh this manually
/// if you update the user-profile on database

class AuthController extends StateNotifier<UserModel?> {
  final AuthService _authService;
  final StateController<AuthException> _authExceptState;

  AuthController(this._authService, this._authExceptState) : super(null) {
    _authService.authState.listen((user) => state = user);
  }

  bool get userLoggedIn => _authService.userLoggedIn;

  Future<bool> signin(String email, String password) async {
    try {
      await _authService.signin(email, password);
      return true;
      //
    } on FirebaseAuthException catch (e) {
      _authExceptState.state = AuthException.signin(e.shortMessage);
      //
    } catch (e) {
      _authExceptState.state = AuthException.unknown(e.toString());
    }
    return false;
  }

  Future<bool> signup(String name, String email, String password) async {
    try {
      final user = await _authService.signup(name, email, password);
      state = user;
      return true;
      //
    } on FirebaseAuthException catch (e) {
      _authExceptState.state = AuthException.signup(e.shortMessage);
      //
    } catch (e) {
      _authExceptState.state = AuthException.unknown(e.toString());
    }
    return false;
  }

  Future<bool> continueWithGoogle() async {
    try {
      final user = await _authService.continueWithGoogle();
      if (user != null) {
        state = user;
        return true;
      }
      //
    } on FirebaseAuthException catch (e) {
      _authExceptState.state = AuthException.google(e.shortMessage);
      //
    } catch (e) {
      _authExceptState.state = AuthException.unknown(e.toString());
    }
    return false;
  }

  Future<void> signout() async {
    await _authService.signout();
    state = null;
  }
}
