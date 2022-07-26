import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/errors/rtdm_exception.dart';
import 'package:todo/models/text_message_model.dart';
import 'package:todo/states/controllers_state.dart';

import '../../models/friend_holder_model.dart';
import '../repos_state.dart';

final providerOfUserFriends = StreamProvider.autoDispose<List<FriendHolderModel>?>(
  (ref) {
    final uid = ref.watch(providerOfAuthController.select((user) => user?.uid));
    if (uid == null) return Stream.error("providerOfUserFriends: user not found");

    return ref
        .read(providerOfBaseRTDMRepository)
        .listenFriends(uid)
        .asyncMap<List<FriendHolderModel>?>(
      (friends) async {
        if (friends == null) return null;

        return Future.wait(
          friends.entries.map<Future<FriendHolderModel>>((entry) async {
            final fuid = entry.key;
            final crid = entry.value;
            final friend =
                await ref.read(providerOfBaseDBRepository).getRecord(fuid);

            if (friend == null) {
              throw ChatException.noUser(
                "providerOfUserFriends. no user for uid $fuid",
              );
            }
            return FriendHolderModel(crid: crid, user: friend);
          }),
        );
      },
    );
  },
);

final providerOfLastMsg =
    StreamProvider.autoDispose.family<TextMessageModel, String>(
  (ref, crid) {
    return ref
        .read(providerOfBaseRTDMRepository)
        .listenLastTextMessage(crid)
        .asyncMap<TextMessageModel>(
      (mid) async {
        if (mid.isEmpty) {
          throw ChatException.noMsg("providerOfLastMsg: mid is empty");
        }
        final msg = await ref.read(providerOfBaseRTDMRepository).getTextMessage(mid);
        if (msg == null) {
          throw ChatException.noMsg("providerOfLastMsg: no msg for mid $mid");
        }
        return msg;
      },
    );
  },
);
