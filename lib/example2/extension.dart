import 'dart:developer';

extension Logs on Object {
  void loged() => log(toString());
}

extension Subsript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}
