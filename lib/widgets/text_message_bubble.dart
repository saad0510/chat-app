import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/text_message_model.dart';
import '../states/controllers_state.dart';

final providerOfTextMessage = Provider<TextMessageModel>(
  (ref) => throw UnimplementedError(),
);

class TextMessageBubble extends ConsumerWidget {
  const TextMessageBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.read(providerOfTextMessage);
    final myUid = ref.watch(providerOfChatController.notifier).uid;
    bool isSender = myUid == message.sender;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        constraints: const BoxConstraints(
          maxWidth: 250,
          maxHeight: 100,
        ),
        decoration: BoxDecoration(
          color: isSender
              // ? Theme.of(context).colorScheme.primary
              // : Theme.of(context).colorScheme.secondary,
              ? Colors.black
              : Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.content,
          overflow: TextOverflow.clip,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
