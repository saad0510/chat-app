import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/auth_repository.dart';
import '../repositories/base/base_auth_repository.dart';
import '../repositories/base/base_db_repository.dart';
import '../repositories/base/base_rtdm_repository.dart';
import '../repositories/db_repository.dart';
import '../repositories/rtdm_repository.dart';
import 'firebase_state.dart';

final providerOfAuthRepository = Provider<BaseAuthRepository>(
  (ref) {
    final auth = ref.read(providerOfFirebaseAuth);
    final google = ref.read(providerOfGoogleAuth);
    return AuthRepository(auth, google);
  },
);

final providerOfDBRepository = Provider<BaseDBRepository>(
  (ref) {
    final db = ref.read(providerOfFireStore);
    return DBRepository(db);
  },
);

final providerOfRTDMRepository = Provider<BaseRealTimeDatabaseRepository>(
  (ref) {
    final rtdm = ref.read(providerOfRealTimeDatabase);
    return RealTimeDatabaseRepository(rtdm);
  },
);
