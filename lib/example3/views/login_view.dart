
import 'package:bloc_learning/example3/views/email_textfield.dart';
import 'package:bloc_learning/example3/views/login_button.dart';
import 'package:bloc_learning/example3/views/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({
    super.key,
    required this.onLoginTapped,
  });

  final OnLoginTapped onLoginTapped;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          EmailTextField(
            textEditingController: emailController,
          ),
          PasswordTextField(
            textEditingController: passwordController,
          ),
          LoginButton(
            emailTextEditingController: emailController,
            passwordController: passwordController,
            onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
