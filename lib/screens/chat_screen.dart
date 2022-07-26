import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/chat_body.dart';
import '../models/user_model.dart';
import '../states/controllers_state.dart';
import '../widgets/send_message_field.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const route = "/chat";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friend = ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          textColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          title: Text(friend.name, overflow: TextOverflow.ellipsis),
          subtitle: const Text("online"),
          leading: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.8),
            backgroundImage: NetworkImage(friend.image),
            onBackgroundImageError: (_, __) {},
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatBody()),
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(10),
            child: SendMessageField(
              onSend: (msg) => ref
                  .read(providerOfChatController.notifier)
                  .sendMessage(friend.uid, msg),
            ),
          ),
        ],
      ),
    );
  }
}
