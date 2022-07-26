import 'package:firebase_auth/firebase_auth.dart';

import '../errors/auth_exception.dart';
import '../models/user_model.dart';
import '../repositories/base/base_auth_repository.dart';
import '../repositories/base/base_db_repository.dart';

class AuthService {
  final BaseAuthRepository _authRepo;
  final BaseDBRepository _dbRepo;

  AuthService(this._authRepo, this._dbRepo);

  /// always use  userLoggedIn before using authUser
  bool get userLoggedIn => _authRepo.currentUser != null;

  User get authUser => _authRepo.currentUser!;

  Stream<UserModel?> get authState =>
      _authRepo.authStateChanges.asyncMap<UserModel?>(
        (user) async {
          if (user == null) return null;
          return await _dbRepo.getRecord(user.uid);
        },
      );

  Future<void> signin(String email, String password) async {
    await _authRepo.signin(
      UserModel.only(
        email: email,
        password: password,
      ),
    );
  }

  Future<UserModel> signup(String name, String email, String password) async {
    await _authRepo.signup(
      UserModel.only(
        email: email,
        password: password,
      ),
    );

    if (userLoggedIn == false) {
      throw AuthException.noUser("AuthService.signup: no user after signup");
    }
    final user = UserModel(
      uid: authUser.uid,
      name: name,
      email: email,
      password: password,
      image: "",
      withGoogle: false,
      verfied: false,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await _dbRepo.createRecord(user);
    return user;
  }

  Future<UserModel?> continueWithGoogle() async {
    bool success = await _authRepo.continueWithGoogle();
    if (success == false) {
      return null;
    }
    if (userLoggedIn == false) {
      throw AuthException.noUser("AuthService.continueWithGoogle: no user found");
    }
    final user = UserModel.fromAuthUser(authUser);
    await _dbRepo.createRecordIfNew(user);
    return user;
  }

  Future<void> signout() async {
    await _authRepo.signout();
  }

  Future<UserModel> getUserInfo() async {
    if (userLoggedIn == false) {
      throw AuthException.noUser("AuthService.getUserInfo: user is not logged-in");
    }
    final data = await _dbRepo.getRecord(authUser.uid);
    if (data == null) {
      throw AuthException.noUser("AuthService.getUserInfo: no user exits");
    }
    return data;
  }
}
