import 'package:flutter/material.dart';

class SearchUsersField extends StatelessWidget {
  const SearchUsersField({Key? key, required this.onChanged}) : super(key: key);

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        hintText: "Search your friends",
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }
}
