import 'dart:developer';

enum PersonUrl {
  person1,
  person2,
}

extension Logs on Object {
  void loged() => log(toString());
}

extension Subsript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:53488/api/person1.json';

      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/api/person2.json';
    }
  }
}
