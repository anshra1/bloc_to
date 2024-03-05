
import 'package:bloc_learning/example2/bloc/fetch_result.dart';
import 'package:bloc_learning/example2/bloc/load_action.dart';
import 'package:bloc_learning/example2/bloc/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonBloc extends Bloc<LoadActionEvent, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonsActions>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          final cachedPersons = _cache[url];
          final result = FetchResult(
            persons: cachedPersons!,
            isRetrievedFromCache: true,
          );
        

          emit(result);
        } else {
          final loader = event.personsLoader;

          final persons = await loader(url);
          _cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}

extension IsEquelToIgnoringOrdering<T> on Iterable<T> {
  bool isEquelToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}
