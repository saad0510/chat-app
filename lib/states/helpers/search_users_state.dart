import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';
import '../controllers_state.dart';
import '../repos_state.dart';

final providerOfSearchUsers =
    StreamProvider.family.autoDispose<List<UserModel>, String>(
  (ref, query) {
    String? username = ref.watch(
      providerOfAuthController.select((user) => user?.name),
    );

    if (query.isEmpty) {
      return Stream.error("Start typing a username");
    }
    return ref
        .read(providerOfBaseDBRepository)
        .searchUsers(query, excluded: username ?? "", limit: 10);
  },
);
