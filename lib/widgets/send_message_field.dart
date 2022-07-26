import 'package:flutter/material.dart';

class SendMessageField extends StatelessWidget {
  SendMessageField({Key? key, required this.onSend}) : super(key: key);

  final void Function(String) onSend;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: "Type a message",
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 15),
        suffixIcon: IconButton(
          onPressed: send,
          icon: const Icon(Icons.send_rounded),
        ),
      ),
      onSubmitted: (_) => send(),
    );
  }

  void send() {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    controller.clear();
    onSend(value);
  }
}
