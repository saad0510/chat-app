import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/home_screen.dart';
import '../../states/controllers_state.dart';
import 'signin_form.dart';
import 'signup_form.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  bool showSignIn = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //
        children: <Widget>[
          showSignIn
              ? SignInForm(
                  formKey: formKey,
                  onSubmit: signin,
                )
              : SignUpForm(
                  formKey: formKey,
                  onSubmit: signup,
                ),
          // secondary-actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                onPressed: () => setState(() => showSignIn = !showSignIn),
                child: Text(showSignIn ? "Sign up" : "Sign in"),
              ),
              OutlinedButton(
                onPressed: google,
                child: const Text("Continue with Google"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signin(String email, String pass) async {
    bool success =
        await ref.read(providerOfAuthController.notifier).signin(email, pass);
    if (success) gotoHome();
  }

  void signup(String name, String email, String pass) async {
    bool success =
        await ref.read(providerOfAuthController.notifier).signup(name, email, pass);
    if (success) gotoHome();
  }

  void google() async {
    bool success =
        await ref.read(providerOfAuthController.notifier).continueWithGoogle();
    if (success) gotoHome();
  }

  void gotoHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.route);
  }
}
