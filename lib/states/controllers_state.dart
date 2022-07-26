import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';
import '../controllers/chat_controller.dart';
import '../errors/auth_exception.dart';
import '../models/chatroom_model.dart';
import '../models/user_model.dart';
import 'services_state.dart';

final providerOfAuthController = StateNotifierProvider<AuthController, UserModel?>(
  (ref) {
    final authService = ref.read(providerOfAuthService);
    final authExceptController = ref.read(providerOfAuthException.notifier);
    return AuthController(authService, authExceptController);
  },
);
final providerOfAuthException = StateProvider<AuthException>(
  (ref) {
    return AuthException.empty();
  },
);

final providerOfChatController =
    StateNotifierProvider<ChatController, ChatroomModel?>(
  (ref) {
    final chatService = ref.read(providerOfChatService);
    // watch for user changes:
    final uid = ref.watch(
      providerOfAuthController.select(
        (user) => user == null ? "" : user.uid,
      ),
    );
    return ChatController(chatService, uid: uid);
  },
);
