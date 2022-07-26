import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.hintText,
    this.validator,
    this.onSaved,
    this.icon = Icons.lock,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        suffixIcon: IconButton(
          onPressed: () => setState(() => hide = !hide),
          icon: Icon(
            Icons.remove_red_eye_rounded,
            color: hide ? Colors.grey : null,
          ),
        ),
      ),
      obscureText: hide,
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
