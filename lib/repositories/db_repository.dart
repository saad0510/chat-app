import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import 'base/base_db_repository.dart';

class DBRepository extends BaseDBRepository {
  final FirebaseFirestore _db;
  static const usersCollection = "users";

  DBRepository(this._db);

  @override
  Future<void> createRecord(UserModel user) async {
    await _db.collection(usersCollection).doc(user.uid).set(user.toMap());
  }

  @override
  Future<void> createRecordIfNew(UserModel user) async {
    final docRef = _db.collection(usersCollection).doc(user.uid);
    final doc = await docRef.get();
    if (doc.exists == false) {
      await docRef.set(user.toMap());
    }
  }

  @override
  Future<UserModel?> getRecord(String uid) async {
    final doc = await _db.collection(usersCollection).doc(uid).get();
    if (doc.data() == null) {
      return null;
    }
    return UserModel.fromMap(doc.data()!);
  }

  @override
  Stream<List<UserModel>> searchUsers(
    String incompleteName, {
    String excluded = "",
    int limit = 10,
  }) {
    return _db
        .collection(usersCollection)
        .where("name", isNotEqualTo: excluded)
        .where("name", isGreaterThanOrEqualTo: incompleteName)
        .where("name", isLessThanOrEqualTo: "$incompleteName~")
        .limit(limit)
        .snapshots()
        .map<List<UserModel>>(
          (x) => x.docs.map((e) => UserModel.fromMap(e.data())).toList(),
        );
  }
}
