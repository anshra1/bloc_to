import 'package:bloc_to/example2/person.dart';

class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult(persons: $persons, isRetrievedFromCache: $isRetrievedFromCache)';
}
