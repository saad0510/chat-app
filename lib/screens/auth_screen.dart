import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/auth_exception.dart';
import '../states/controllers_state.dart';
import '../widgets/form/auth_form.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const route = "/auth";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final colors = Theme.of(context).colorScheme;
    const headerHeight = 200.0;

    // dispatch error messages
    ref.listen(
      providerOfAuthException,
      (_, AuthException error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colors.error,
            content: Text(error.message),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: colors.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceWidth,
            minHeight: deviceHeight,
          ),
          child: Column(
            children: [
              // header
              SizedBox(
                height: headerHeight,
                child: Center(
                  child: Icon(
                    Icons.message_rounded,
                    color: colors.onPrimary,
                    size: 70,
                  ),
                ),
              ),
              // bottom-dialogue
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                constraints: BoxConstraints(
                  maxWidth: 500,
                  minHeight: deviceHeight - headerHeight,
                ),
                width: double.infinity, // expand to maxWidth
                decoration: BoxDecoration(
                  color: colors.onPrimary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: const AuthForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
