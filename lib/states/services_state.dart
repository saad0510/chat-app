import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_service.dart';
import '../services/chat_service.dart';
import 'repos_state.dart';

final providerOfAuthService = Provider<AuthService>(
  (ref) {
    final authRepo = ref.read(providerOfBaseAuthRepository);
    final dbRepo = ref.read(providerOfBaseDBRepository);
    return AuthService(authRepo, dbRepo);
  },
);

final providerOfChatService = Provider<ChatService>(
  (ref) {
    final rtdmRepo = ref.read(providerOfBaseRTDMRepository);
    return ChatService(rtdmRepo);
  },
);
