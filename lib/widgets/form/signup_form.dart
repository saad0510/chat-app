import 'package:flutter/material.dart';

import '../../utils/form_validation.dart' as utils;
import 'custom_form_field.dart';
import 'password_form_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.onSubmit,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final void Function(
    String name,
    String email,
    String password,
  ) onSubmit;

  @override
  Widget build(BuildContext context) {
    String name = "";
    String email = "";
    String password = "";
    String confirmPassword = "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomFormField(
          hintText: "Name",
          icon: Icons.person,
          validator: utils.validateName,
          onSaved: (value) => name = value ?? "",
        ),
        const SizedBox(height: 10),
        CustomFormField(
          hintText: "Email",
          icon: Icons.email,
          validator: utils.validateEmail,
          onSaved: (value) => email = value ?? "",
        ),
        const SizedBox(height: 10),
        PasswordFormField(
          hintText: "Password",
          validator: (v) {
            confirmPassword = v ?? "";
            return utils.validatePass(v);
          },
          onSaved: (value) => password = value ?? "",
        ),
        const SizedBox(height: 10),
        PasswordFormField(
          hintText: "Confirm Password",
          validator: (v) => confirmPassword == v ? null : "Passwords do not match",
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final form = formKey.currentState!;
            if (form.validate()) {
              form.save();
              onSubmit(name, email, password);
            }
          },
          child: const Text("Sign up"),
        ),
      ],
    );
  }
}
