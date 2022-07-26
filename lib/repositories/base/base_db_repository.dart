import '../../models/user_model.dart';

abstract class BaseDBRepository {
  Future<void> createRecord(UserModel user);

  Future<void> createRecordIfNew(UserModel user);

  Future<UserModel?> getRecord(String uid);

  Stream<List<UserModel>> searchUsers(
    String incompleteName, {
    String excluded,
    int limit,
  });
}
