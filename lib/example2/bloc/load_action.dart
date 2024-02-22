import 'package:bloc_to/example2/extension.dart';

import 'package:flutter/material.dart';

@immutable
abstract class LoadActionEvent {
  const LoadActionEvent();
}

@immutable
class LoadPersonsActions implements LoadActionEvent {
  final PersonUrl url;

  const LoadPersonsActions({required this.url}) : super();
}

