import 'package:bloc_learning/example3/dialog/generic_dialog.dart';
import 'package:bloc_learning/example3/strings.dart';

import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.emailTextEditingController,
    required this.passwordController,
    required this.onLoginTapped,
  });

  final TextEditingController emailTextEditingController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTapped;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailTextEditingController.text;
        final password = passwordController.text;
        if (email.isEmpty || password.isEmpty) {
          showGenericDialog<bool>(
            context: context,
            titele: emailOrPasswordEmptyDialogTitle,
            content: emailOrPasswordEmptyDescription,
            optionBuildr: () => {
              ok: true,
            },
          );
        } else {
          onLoginTapped(email, password);
        }
      },
      child: const Text(login),
    );
  }
}
