
import 'package:bloc_to/example2/bloc/fetch_result.dart';
import 'package:bloc_to/example2/extension.dart';
import 'package:bloc_to/example2/get_person.dart';
import 'package:bloc_to/example2/bloc/load_action.dart';

import 'package:bloc_to/example2/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonBloc extends Bloc<LoadActionEvent, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
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
          print(result);

          emit(result);
        } else {
          final persons = await getPersons(url.urlString);
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
