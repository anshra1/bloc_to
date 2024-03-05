
import 'package:bloc_learning/example2/bloc/person.dart';
import 'package:equatable/equatable.dart';

class FetchResult extends Equatable {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult(persons: $persons, isRetrievedFromCache: $isRetrievedFromCache)';

  @override
  List<Object?> get props => [persons, isRetrievedFromCache];
}
