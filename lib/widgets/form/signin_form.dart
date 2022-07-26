import 'package:flutter/material.dart';

import '../../utils/form_validation.dart' as utils;
import 'custom_form_field.dart';
import 'password_form_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
    required this.onSubmit,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final void Function(
    String email,
    String password,
  ) onSubmit;

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomFormField(
          hintText: "Email",
          icon: Icons.email,
          validator: utils.validateEmail,
          onSaved: (value) => email = value!,
        ),
        const SizedBox(height: 10),
        PasswordFormField(
          hintText: "Password",
          validator: utils.validatePass,
          onSaved: (value) => password = value!,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final form = formKey.currentState!;
            if (form.validate()) {
              form.save();
              onSubmit(email, password);
            }
          },
          child: const Text("Sign in"),
        ),
      ],
    );
  }
}
