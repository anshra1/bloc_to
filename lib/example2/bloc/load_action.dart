
import 'package:bloc_learning/example2/bloc/person.dart';
import 'package:flutter/material.dart';

const person1url = 'http://127.0.0.1:5500/api/person1.json';
const person2url = 'http://127.0.0.1:5500/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadActionEvent {
  const LoadActionEvent();
}

@immutable
class LoadPersonsActions implements LoadActionEvent {
  final String url;
  final PersonsLoader personsLoader;

  const LoadPersonsActions({
    required this.url,
    required this.personsLoader,
  }) : super();
}
