import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/base/base_auth_repository.dart';
import '../repositories/base/base_db_repository.dart';
import '../repositories/base/base_rtdm_repository.dart';

final providerOfBaseAuthRepository = Provider<BaseAuthRepository>(
  (ref) {
    throw UnimplementedError(
      "override the base repository with your implementation",
    );
  },
);

final providerOfBaseDBRepository = Provider<BaseDBRepository>(
  (ref) {
    throw UnimplementedError(
      "override the base repository with your implementation",
    );
  },
);

final providerOfBaseRTDMRepository = Provider<BaseRealTimeDatabaseRepository>(
  (ref) {
    throw UnimplementedError(
      "override the base repository with your implementation",
    );
  },
);
