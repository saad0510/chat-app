import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/text_message_model.dart';
import '../controllers_state.dart';
import '../repos_state.dart';

final providerOfChatState = StreamProvider.autoDispose<List<TextMessageModel>?>(
  (ref) {
    final crid = ref.watch(providerOfChatController.select((chat) => chat?.crid));
    if (crid == null) {
      return Stream.error("providerOfChatState: no chatroom in context");
    }

    return ref.read(providerOfBaseRTDMRepository).listenChatroom(crid);
  },
);
