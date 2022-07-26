import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'text_message_bubble.dart';
import '../states/helpers/chat_state.dart';

class ChatBody extends ConsumerWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: ref.watch(providerOfChatState).when(
            data: (msgs) {
              if (msgs == null) {
                return const Center(
                  child: Text("No messages here"),
                );
              }
              msgs.sort((a, b) => a.timestamp.compareTo(b.timestamp));
              return ListView.builder(
                itemCount: msgs.length,
                itemBuilder: (_, i) => ProviderScope(
                  overrides: [
                    providerOfTextMessage.overrideWithValue(msgs[i]),
                  ],
                  child: const TextMessageBubble(),
                ),
              );
            },
            error: (err, _) => Center(child: Text("$err")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
