import 'package:bloc_learning/example3/strings.dart';

import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const EmailTextField({
    super.key,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: enterYourEmailHere,
      ),
    );
  }
}
