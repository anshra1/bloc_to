import 'dart:typed_data' show Uint8List;
import 'package:bloc_learning/example4/bloc/app_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}

final text1Data = 'Foo'.toUint8List();
final text2Data = 'Bar'.toUint8List();

enum Errors { mockError }

void main() {
  blocTest<AppBloc, AppStateInitial>(
    'initial state of the bloc',
    build: () => AppBloc(
      urls: [],
    ),
    verify: (appBloc) => expect(
      appBloc.state,
      const AppStateInitial.empty(),
    ),
  );

  blocTest<AppBloc, AppStateInitial>(
    'load valid data and compare states',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const AppStateInitial(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppStateInitial(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );

  blocTest<AppBloc, AppStateInitial>(
    'throw an error in urlLoader and catch it',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.error(Errors.mockError),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const AppStateInitial(
        isLoading: true,
        data: null,
        error: null,
      ),
      const AppStateInitial(
        isLoading: false,
        data: null,
        error: Errors.mockError,
      ),
    ],
  );
  blocTest<AppBloc, AppStateInitial>(
    'load valid data and compare states twice',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text2Data),
    ),
    act: (appBloc) {
      appBloc.add(
        const LoadNextUrlEvent(),
      );
      appBloc.add(
        const LoadNextUrlEvent(),
      );
    },
    expect: () => [
      const AppStateInitial(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppStateInitial(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
      const AppStateInitial(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppStateInitial(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
    ],
  );
}
